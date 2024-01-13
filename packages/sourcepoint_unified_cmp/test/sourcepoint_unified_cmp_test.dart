import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

class MockSourcepointUnifiedCmpPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements SourcepointUnifiedCmpPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SourcepointUnifiedCmp', () {
    late SourcepointUnifiedCmpPlatform sourcepointUnifiedCmpPlatform;

    setUp(() {
      sourcepointUnifiedCmpPlatform = MockSourcepointUnifiedCmpPlatform();
      SourcepointUnifiedCmpPlatform.instance = sourcepointUnifiedCmpPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => sourcepointUnifiedCmpPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => sourcepointUnifiedCmpPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
