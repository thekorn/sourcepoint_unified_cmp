import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_ios/sourcepoint_unified_cmp_ios.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SourcepointUnifiedCmpIOS', () {
    const kPlatformName = 'iOS';
    late SourcepointUnifiedCmpIOS sourcepointUnifiedCmp;
    late List<MethodCall> log;

    setUp(() async {
      sourcepointUnifiedCmp = SourcepointUnifiedCmpIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(sourcepointUnifiedCmp.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      SourcepointUnifiedCmpIOS.registerWith();
      expect(SourcepointUnifiedCmpPlatform.instance, isA<SourcepointUnifiedCmpIOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await sourcepointUnifiedCmp.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
