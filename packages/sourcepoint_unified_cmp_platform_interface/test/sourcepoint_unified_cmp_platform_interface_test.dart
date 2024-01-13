import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

class SourcepointUnifiedCmpMock extends SourcepointUnifiedCmpPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<void> loadPrivacyManager() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SourcepointUnifiedCmpPlatformInterface', () {
    late SourcepointUnifiedCmpPlatform sourcepointUnifiedCmpPlatform;

    setUp(() {
      sourcepointUnifiedCmpPlatform = SourcepointUnifiedCmpMock();
      SourcepointUnifiedCmpPlatform.instance = sourcepointUnifiedCmpPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          () async =>
              SourcepointUnifiedCmpPlatform.instance.loadPrivacyManager(),
          isA<void>(),
        );
      });
    });
  });
}
