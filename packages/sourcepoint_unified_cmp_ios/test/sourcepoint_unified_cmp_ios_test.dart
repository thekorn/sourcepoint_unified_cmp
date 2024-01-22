import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp_ios/src/messages.g.dart';

class MockMethodChannel extends Mock implements MethodChannel {
  MockMethodChannel(this.mockBinaryMessenger);
  final MockBinaryMessenger mockBinaryMessenger;

  @override
  BinaryMessenger get binaryMessenger {
    return mockBinaryMessenger;
  }
}

class MockBinaryMessenger extends Mock implements BinaryMessenger {}

class MockSourcepointUnifiedCmpHostApi extends Mock
    implements SourcepointUnifiedCmpHostApi {}

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
        campaignsEnv: HostAPICampaignsEnv.publicEnv,
        messageTimeout: 10000,
        runGDPRCampaign: true,
        runCCPACampaign: false,
      ),
    ).thenAnswer((_) async => HostAPISPConsent());
    final consent = await api.loadMessage(
      accountId: 22,
      propertyId: 7639,
      propertyName: 'tcfv2.mobile.webview',
      pmId: '122058',
      messageLanguage: HostAPIMessageLanguage.german,
      campaignsEnv: HostAPICampaignsEnv.publicEnv,
      messageTimeout: 10000,
      runGDPRCampaign: true,
      runCCPACampaign: false,
    );
    expect(consent, isNotNull);
  });
}
