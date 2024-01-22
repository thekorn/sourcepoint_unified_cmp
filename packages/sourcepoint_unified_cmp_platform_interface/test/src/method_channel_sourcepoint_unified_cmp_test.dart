import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$MethodChannelSourcepointUnifiedCmp', () {
    late MethodChannelSourcepointUnifiedCmp methodChannelSourcepointUnifiedCmp;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelSourcepointUnifiedCmp = MethodChannelSourcepointUnifiedCmp();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelSourcepointUnifiedCmp.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'loadPrivacyManager':
              return null;
            case 'loadMessage':
              return SPConsent();
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('loadPrivacyManager', () async {
      await methodChannelSourcepointUnifiedCmp.loadPrivacyManager(
        '122058',
        PMTab.purposes,
        CampaignType.gdpr,
        MessageType.mobile,
      );
      expect(
        log,
        <Matcher>[isMethodCall('loadPrivacyManager', arguments: null)],
      );
    });

    // TODO(thekorn): fix test
    //test('loadMessage', () async {
    //  await methodChannelSourcepointUnifiedCmp.loadMessage(
    //    SPConfig(
    //      accountId: 22,
    //      propertyId: 7639,
    //      propertyName: 'tcfv2.mobile.webview',
    //      pmId: '122058',
    //      campaigns: [CampaignType.gdpr],
    //    ),
    //  );
    //  expect(
    //    log,
    //    <Matcher>[isMethodCall('loadMessage', arguments: null)],
    //  );
    //});
  });
}
