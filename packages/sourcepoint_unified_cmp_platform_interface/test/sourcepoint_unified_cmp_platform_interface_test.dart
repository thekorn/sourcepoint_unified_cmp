import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

class SourcepointUnifiedCmpMock extends SourcepointUnifiedCmpPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
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
          await SourcepointUnifiedCmpPlatform.instance.getPlatformName(),
          equals(SourcepointUnifiedCmpMock.mockPlatformName),
        );
      });
    });
  });
}
