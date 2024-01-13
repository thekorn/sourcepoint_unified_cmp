import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel_sourcepoint_unified_cmp.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

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
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName =
          await methodChannelSourcepointUnifiedCmp.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
