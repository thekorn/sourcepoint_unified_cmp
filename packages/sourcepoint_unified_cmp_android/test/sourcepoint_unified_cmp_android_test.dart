import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp_android/sourcepoint_unified_cmp_android.dart';
import 'package:sourcepoint_unified_cmp_android/src/messages.g.dart'
    hide SPConfig;
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

@GenerateNiceMocks([MockSpec<SourcepointUnifiedCmpHostApi>()])
import 'sourcepoint_unified_cmp_android_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSourcepointUnifiedCmpHostApi api;

  setUp(() {
    api = MockSourcepointUnifiedCmpHostApi();
  });

  test('loadMessage', () async {
    when(
      api.loadMessage(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
        messageLanguage: HostAPIMessageLanguage.german,
        campaignsEnv: HostAPICampaignsEnv.public,
        messageTimeout: 10000,
        runGDPRCampaign: true,
        runCCPACampaign: false,
        runUSNATCampaign: false,
        gdprTargetingParams: {},
        ccpaTargetingParams: {},
        usnatTargetingParams: {},
      ),
    ).thenAnswer((_) async => HostAPISPConsent());
    final consent = await api.loadMessage(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
      pmId: '122058',
      messageLanguage: HostAPIMessageLanguage.german,
      campaignsEnv: HostAPICampaignsEnv.public,
      messageTimeout: 10000,
      runGDPRCampaign: true,
      runCCPACampaign: false,
      runUSNATCampaign: false,
      gdprTargetingParams: {},
      ccpaTargetingParams: {},
      usnatTargetingParams: {},
    );
    expect(consent, isNotNull);
  });

  test('customConsentGDPR', () async {
    when(
      api.customConsentGDPR(
        vendors: ['vendor1'],
        categories: ['category1'],
        legIntCategories: ['legIntCategory1'],
      ),
    ).thenAnswer((_) async => HostAPISPConsent());
    final consent = await api.customConsentGDPR(
      vendors: ['vendor1'],
      categories: ['category1'],
      legIntCategories: ['legIntCategory1'],
    );
    expect(consent, isNotNull);
  });

  test('deleteCustomConsentGDPR', () async {
    when(
      api.deleteCustomConsentGDPR(
        vendors: ['vendor1'],
        categories: ['category1'],
        legIntCategories: ['legIntCategory1'],
      ),
    ).thenAnswer((_) async => HostAPISPConsent());
    final consent = await api.deleteCustomConsentGDPR(
      vendors: ['vendor1'],
      categories: ['category1'],
      legIntCategories: ['legIntCategory1'],
    );
    expect(consent, isNotNull);
  });

  test('loadMessage sends each campaign its own targeting params', () async {
    List<Object?>? sent;
    const channel = BasicMessageChannel<Object?>(
      'dev.flutter.pigeon.sourcepoint_unified_cmp_android'
      '.SourcepointUnifiedCmpHostApi.loadMessage',
      SourcepointUnifiedCmpHostApi.pigeonChannelCodec,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockDecodedMessageHandler<Object?>(channel, (message) async {
          sent = message! as List<Object?>;
          return <Object?>[HostAPISPConsent()];
        });
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockDecodedMessageHandler<Object?>(channel, null),
    );

    await SourcepointUnifiedCmpAndroid().loadMessage(
      SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'tcfv2.mobile.webview',
        pmId: '122058',
        campaigns: [CampaignType.gdpr],
        targetingParams: {
          CampaignType.gdpr: {'message': 'pur', 'legal': 'no'},
        },
      ),
      authId: 'user-42',
    );

    expect(sent, contains(equals({'message': 'pur', 'legal': 'no'})));
    expect(sent, contains('user-42'));
  });

  test('onAction reports the id of the custom button that was tapped', () {
    ConsentAction? received;
    SourcepointEventHandler(
      delegate: _RecordingDelegate((action) => received = action),
    ).onAction(
      HostAPIConsentAction(
        actionType: HostAPIActionType.custom,
        pubData: '{}',
        campaignType: HostAPICampaignType.gdpr,
        customActionId: 'pur-subscribe',
      ),
    );
    expect(received?.customActionId, 'pur-subscribe');
  });
}

class _RecordingDelegate extends SourcepointEventDelegatePlatform {
  _RecordingDelegate(void Function(ConsentAction) onAction)
    : super(onAction: onAction);
}
