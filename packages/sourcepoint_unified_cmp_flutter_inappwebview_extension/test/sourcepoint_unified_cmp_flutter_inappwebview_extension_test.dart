import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

@GenerateNiceMocks([MockSpec<InAppWebViewController>()])
import 'sourcepoint_unified_cmp_flutter_inappwebview_extension_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  //test('preloadConsent should run the correct JavaScript in the webview',
  //    () async {
  //  final consent = SPConsent(); // Provide necessary SPConsent object
  //  final postMessageString = '...'; // Provide necessary postMessageString
  //  final jsString = '...'; // Provide necessary jsString
//
  //  final webViewController =
  //      InAppWebViewController.(); // Create a mock WebViewController
  //  webViewController.onPageFinished =
  //      Future.value(); // Set the onPageFinished future to complete
//
  //  await webViewController.preloadConsent(consent: consent);
//
  //  // Verify that the runJavaScript method is called with the correct jsString
  //  expect(webViewController.runJavaScriptCalledWith, jsString);
  //});
}
