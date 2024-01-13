import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_android/sourcepoint_unified_cmp_android.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SourcepointUnifiedCmpAndroid', () {
    const kPlatformName = 'Android';
    late SourcepointUnifiedCmpAndroid sourcepointUnifiedCmp;
    late List<MethodCall> log;

    setUp(() async {
      sourcepointUnifiedCmp = SourcepointUnifiedCmpAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(sourcepointUnifiedCmp.methodChannel,
              (methodCall) async {
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
      SourcepointUnifiedCmpAndroid.registerWith();
      expect(SourcepointUnifiedCmpPlatform.instance,
          isA<SourcepointUnifiedCmpAndroid>());
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
