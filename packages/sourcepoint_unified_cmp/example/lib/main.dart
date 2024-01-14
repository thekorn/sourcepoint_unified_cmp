import 'package:flutter/material.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_example/controller.dart';
import 'package:sourcepoint_unified_cmp_example/types.dart';
import 'package:sourcepoint_unified_cmp_example/widget.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SourcepointController _controller;

  @override
  void initState() {
    super.initState();

    final config = SPConfig(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
      pmId: '122058',
    );

    _controller = SourcepointController(config: config);
    //onConsentUIReady: () {
    //  debugPrint('onConsentUIReady');
    //},
    //onConsentUIFinished: () {
    //  debugPrint('onConsentUIFinished');
    //},
    //onConsentReady: ({GDPRUserConsent? consent}) {
    //  debugPrint('Consent string: ${consent?.consentString}');
    //  debugPrint('Consent action is taken and returned to Sourcepoint');
    //},
    //onAction: (ActionType? action) {
    //  debugPrint('onAction(${action.toString()})');
    //},
    //onError: (errorCode) {
    //  debugPrint('consentError: errorCode:$errorCode');
    //},

    //Show on Start
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SourcepointUnifiedCmp Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                onPressed: () {
                  _controller.loadPrivacyManager();
                },
                child: const Text(
                  'Show PrivacyManager',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
  late final MockController _controller;

  @override
  void initState() {
    super.initState();

    final config = SPConfig(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
      pmId: '122058',
    );

    _controller = MockController(config: config);
    //onConsentUIReady: () {
    //  debugPrint('onConsentUIReady');
    //},
    //onConsentUIFinished: () {
    //  debugPrint('onConsentUIFinished');
    //},
    //onConsentReady: ({GDPRUserConsent? consent}) {
    //  debugPrint('Consent string: ${consent?.consentString}');
    //  debugPrint('Consent action is taken and returned to Sourcepoint');
    //},
    //onAction: (ActionType? action) {
    //  debugPrint('onAction(${action.toString()})');
    //},
    //onError: (errorCode) {
    //  debugPrint('consentError: errorCode:$errorCode');
    //},
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
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
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
