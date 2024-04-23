import 'package:flutter/material.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_webview_extension/sourcepoint_unified_cmp_flutter_webview_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SourcepointUnifiedCMPBuilderExample(),
    );
  }
}

class SourcepointUnifiedCMPBuilderExample extends StatefulWidget {
  const SourcepointUnifiedCMPBuilderExample({super.key});

  @override
  State<SourcepointUnifiedCMPBuilderExample> createState() =>
      _SourcepointUnifiedCMPBuilderExampleState();
}

class _SourcepointUnifiedCMPBuilderExampleState
    extends State<SourcepointUnifiedCMPBuilderExample> {
  late final SourcepointController _controller;
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    final config = SPConfig(
      accountId: 22,
      propertyId: 31007,
      propertyName: 'https://sdks-auth-consent-test-page',
      pmId: '122058',
      campaigns: [CampaignType.gdpr],
    );

    _controller = SourcepointController(config: config)
      ..setEventDelegate(
        SourcepointEventDelegate(
          onConsentReady: (SPConsent consent) {
            debugPrint('DELEGATE onConsentReady: Consent string: '
                '${consent.gdpr?.euconsent}');
          },
          onSpFinished: (SPConsent consent) {
            debugPrint(
              'DELEGATE SpFinished: Consent string: ${consent.gdpr?.euconsent}',
            );
          },
        ),
      );

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('webview sample'),
      ),
      body: Center(
        child: SourcepointUnifiedCMPBuilder(
          controller: _controller,
          builder: (BuildContext context, AsyncSnapshot<SPConsent> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              final consent = snapshot.data;
              debugPrint('user consent has been loaded:');
              debugPrint('   grants: ${consent?.gdpr?.grants}');
              debugPrint('euconsent: ${consent?.gdpr?.euconsent}');
              _webViewController
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onPageFinished: (String url) {
                      _webViewController.preloadConsent(consent: consent!);
                    },
                  ),
                )
                ..loadRequest(
                  Uri.parse(
                    'https://sourcepointusa.github.io/sdks-auth-consent-test-page/?_sp_version=4.9.0&_sp_pass_consent=true',
                  ),
                );
              return WebViewWidget(controller: _webViewController);
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting consent...'),
                ),
              ];
            }
            return SingleChildScrollView(
              child: Column(
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
