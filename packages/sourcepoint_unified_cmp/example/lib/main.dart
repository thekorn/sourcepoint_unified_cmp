import 'package:flutter/material.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
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

    _controller = SourcepointController()
      ..setCmpConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
      );
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
    _controller.load();
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
