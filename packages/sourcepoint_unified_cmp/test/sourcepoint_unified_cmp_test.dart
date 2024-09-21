import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';

@GenerateNiceMocks([MockSpec<MethodChannelSourcepointUnifiedCmp>()])
import 'sourcepoint_unified_cmp_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMethodChannelSourcepointUnifiedCmp methodChannel;

  setUp(() {
    methodChannel = MockMethodChannelSourcepointUnifiedCmp();
    SourcepointUnifiedCmpPlatform.setInstanceUnverified(methodChannel);
  });

  test('loadMessage', () async {
    final config = SPConfig(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
      pmId: '122058',
      campaigns: [CampaignType.gdpr],
    );
    when(
      methodChannel.loadMessage(any),
    ).thenAnswer((_) async => SPConsent());
    final controller = SourcepointController(config: config);
    final r = await controller.loadMessage();
    expect(r, isNotNull);
  });

  group('WebView Utils', () {
    test(
        // ignore: lines_longer_than_80_chars
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
  });
}
