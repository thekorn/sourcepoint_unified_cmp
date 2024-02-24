import 'package:flutter/material.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_webview_extension_example/widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SourcepointunifiedCMPBuilderExample());
  }
}

class SourcepointunifiedCMPBuilderExample extends StatefulWidget {
  const SourcepointunifiedCMPBuilderExample({super.key});

  @override
  State<SourcepointunifiedCMPBuilderExample> createState() =>
      _SourcepointunifiedCMPBuilderExampleState();
}

class _SourcepointunifiedCMPBuilderExampleState
    extends State<SourcepointunifiedCMPBuilderExample> {
  late final SourcepointController _controller;

  @override
  void initState() {
    super.initState();

    final config = SPConfig(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
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
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: SourcepointUnifiedCMPBuilder(
        controller: _controller,
        builder: (BuildContext context, AsyncSnapshot<SPConsent> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            final consent = snapshot.data;
            debugPrint('user consent has been loaded:');
            debugPrint('   grants: ${consent?.gdpr?.grants}');
            debugPrint('euconsent: ${consent?.gdpr?.euconsent}');
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Result: we got initial consent'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () {
                    _controller.loadPrivacyManager(
                      pmId: '122058',
                    );
                  },
                  child: const Text('Load Privacy Manager'),
                ),
              ),
            ];
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
