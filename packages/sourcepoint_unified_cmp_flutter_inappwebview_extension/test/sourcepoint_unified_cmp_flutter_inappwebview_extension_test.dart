import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_flutter_inappwebview_extension/sourcepoint_unified_cmp_flutter_inappwebview_extension.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test(
      'generatePostMessageString should return the correct post message string',
      () {
    final consent = SPConsent(); // Provide necessary SPConsent object
    final expectedPostMessageString = '''
    window.postMessage({
        name: "sp.loadConsent",
        consent: $consent
    }, "*")
    '''
        .trim();

    final postMessageString = generatePostMessageString(consent);

    expect(postMessageString, expectedPostMessageString);
  });

  test('generateJSString should return the correct JavaScript string', () {
    const postMessageString = '...'; // Provide necessary postMessageString
    final expectedJSString = """
        $postMessageString
        window.addEventListener('message', (event) => {
            if (event && event.data && event.data.name === "sp.readyForConsent") {
                $postMessageString
            }
        })
    """
        .trim();

    final jsString = generateJSString(postMessageString);

    expect(jsString, expectedJSString);
  });

  //test('preloadConsent should run the correct JavaScript in the webview',
  //    () async {
  //  final consent = SPConsent(); // Provide necessary SPConsent object
  //  final postMessageString = '...'; // Provide necessary postMessageString
  //  final jsString = '...'; // Provide necessary jsString
//
  //  final webViewController =
  //      WebViewController(); // Create a mock WebViewController
  //  webViewController.onPageFinished =
  //      Future.value(); // Set the onPageFinished future to complete
//
  //  await webViewController.preloadConsent(consent: consent);
//
  //  // Verify that the runJavaScript method is called with the correct jsString
  //  expect(webViewController.runJavaScriptCalledWith, jsString);
  //});
}
