import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

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
        consent: ${consent.webConsents}
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
}
