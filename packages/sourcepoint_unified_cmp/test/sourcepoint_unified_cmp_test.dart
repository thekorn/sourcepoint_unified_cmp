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
    when(methodChannel.loadMessage(any)).thenAnswer((_) async => SPConsent());
    final controller = SourcepointController(config: config);
    final r = await controller.loadMessage();
    expect(r, isNotNull);
  });

  group('WebView Utils', () {
    test(
      'generatePreloadJSString should return the correct JavaScript string',
      () {
        final consent = SPConsent(webConsents: 'boo');
        final expectedGeneratePreloadJSString =
            '''
          window.postMessage({
              name: "sp.loadConsent",
              consent: boo
          }, "*")
          window.addEventListener('message', (event) => {
              if (event && event.data && event.data.name === "sp.readyForConsent") {
                  window.postMessage({
                      name: "sp.loadConsent",
                      consent: boo
                  }, "*")
              }
          })
        '''
                .replaceAll(' ', '')
                .trim();

        final jsString = generatePreloadJSString(consent);

        expect(jsString.replaceAll(' ', ''), expectedGeneratePreloadJSString);
      },
    );

    test(
      // ignore: lines_longer_than_80_chars
      'generatePreloadJSString should throw an AssertionError when webConsents is null',
      () {
        // ignore: avoid_redundant_argument_values
        final consent = SPConsent(webConsents: null);

        expect(() => generatePreloadJSString(consent), throwsAssertionError);
      },
    );
  });
}
