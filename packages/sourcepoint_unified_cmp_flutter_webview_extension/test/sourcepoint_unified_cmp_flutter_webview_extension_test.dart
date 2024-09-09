import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_webview_extension/sourcepoint_unified_cmp_flutter_webview_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

@GenerateNiceMocks([MockSpec<WebViewPlatform>()])
import 'sourcepoint_unified_cmp_flutter_webview_extension_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test('preloadConsent should run the correct JavaScript in the webview',
      () async {
    final consent = SPConsent(); // Provide necessary SPConsent object
    final postMessageString = '...'; // Provide necessary postMessageString
    final jsString = '...'; // Provide necessary jsString

    final webViewController =
        WebViewController(); // Create a mock WebViewController
    // webViewController.
    //     Future.value(); // Set the onPageFinished future to complete

    await webViewController.preloadConsent(consent: consent);

    // Verify that the runJavaScript method is called with the correct jsString
    verify(webViewController.runJavaScript).called(1);
  });
}
