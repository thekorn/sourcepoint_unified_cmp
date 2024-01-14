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

    //group('loadPrivacyManager', () {
    //  test('load the privacy manager', () async {
    //    when(
    //      () => sourcepointUnifiedCmpPlatform.loadPrivacyManager(),
    //    ).thenAnswer((_) async {});
    //    expect(() async => loadPrivacyManager(), isA<void>());
    //  });
    //});
  });
}
