import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp_android/src/messages.g.dart';

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
}
