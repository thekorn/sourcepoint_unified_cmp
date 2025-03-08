import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_web/sourcepoint_unified_cmp_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SourcepointUnifiedCmpWeb', () {
    const kPlatformName = 'Web';
    late SourcepointUnifiedCmpWeb sourcepointUnifiedCmp;

    setUp(() async {
      sourcepointUnifiedCmp = SourcepointUnifiedCmpWeb();
    });

    test('can be registered', () {
      SourcepointUnifiedCmpWeb.registerWith();
      expect(SourcepointUnifiedCmpPlatform.instance, isA<SourcepointUnifiedCmpWeb>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await sourcepointUnifiedCmp.getPlatformName();
      expect(name, equals(kPlatformName));
    });
  });
}
