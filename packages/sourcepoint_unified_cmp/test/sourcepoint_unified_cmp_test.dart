import 'package:flutter/material.dart';
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

  group('SourcepointController', () {
    test('setEventDelegate registers the delegate with the platform', () {
      final config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
        campaigns: [CampaignType.gdpr],
      );
      final delegate = SourcepointEventDelegate();
      final controller = SourcepointController(config: config);

      controller.setEventDelegate(delegate);

      verify(methodChannel.registerEventDelegate(delegate)).called(1);
    });

    test(
      'loadPrivacyManager calls the platform with correct parameters',
      () async {
        final config = SPConfig(
          accountId: 22,
          propertyId: 7639,
          propertyName: 'tcfv2.mobile.webview',
          pmId: '122058',
          campaigns: [CampaignType.gdpr],
        );
        when(
          methodChannel.loadPrivacyManager(any, any, any, any),
        ).thenAnswer((_) async {});

        final controller = SourcepointController(config: config);
        await controller.loadPrivacyManager(pmId: '122058');

        verify(
          methodChannel.loadPrivacyManager(
            '122058',
            PMTab.purposes,
            CampaignType.gdpr,
            MessageType.mobile,
          ),
        ).called(1);
      },
    );

    test(
      'loadPrivacyManager forwards all optional parameters to the platform',
      () async {
        final config = SPConfig(
          accountId: 22,
          propertyId: 7639,
          propertyName: 'tcfv2.mobile.webview',
          pmId: '122058',
          campaigns: [CampaignType.gdpr],
        );
        when(
          methodChannel.loadPrivacyManager(any, any, any, any),
        ).thenAnswer((_) async {});

        final controller = SourcepointController(config: config);
        await controller.loadPrivacyManager(
          pmId: '999',
          pmTab: PMTab.vendors,
          campaignType: CampaignType.ccpa,
          messageType: MessageType.ott,
        );

        verify(
          methodChannel.loadPrivacyManager(
            '999',
            PMTab.vendors,
            CampaignType.ccpa,
            MessageType.ott,
          ),
        ).called(1);
      },
    );
  });

  group('SourcepointUnifiedCMPBuilder', () {
    testWidgets('shows builder content after future resolves', (tester) async {
      final consent = SPConsent(webConsents: 'test_consent');
      final config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
        campaigns: [CampaignType.gdpr],
      );
      when(methodChannel.loadMessage(any)).thenAnswer((_) async => consent);

      final controller = SourcepointController(config: config);

      await tester.pumpWidget(
        MaterialApp(
          home: SourcepointUnifiedCMPBuilder(
            controller: controller,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Text('loaded');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      );

      // Initially shows loading indicator before future resolves.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // After the future resolves, shows the content.
      await tester.pumpAndSettle();
      expect(find.text('loaded'), findsOneWidget);
    });

    testWidgets('passes SPConsent snapshot to builder', (tester) async {
      final consent = SPConsent(webConsents: 'web_consent');
      final config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
        campaigns: [CampaignType.gdpr],
      );
      when(methodChannel.loadMessage(any)).thenAnswer((_) async => consent);

      SPConsent? receivedConsent;
      final controller = SourcepointController(config: config);

      await tester.pumpWidget(
        MaterialApp(
          home: SourcepointUnifiedCMPBuilder(
            controller: controller,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                receivedConsent = snapshot.data;
                return const Text('done');
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(receivedConsent, consent);
    });
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
