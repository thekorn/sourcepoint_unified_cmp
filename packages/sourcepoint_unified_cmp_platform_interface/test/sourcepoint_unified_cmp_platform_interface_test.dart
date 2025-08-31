import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';

@GenerateNiceMocks([MockSpec<MethodChannelSourcepointUnifiedCmp>()])
import 'sourcepoint_unified_cmp_platform_interface_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMethodChannelSourcepointUnifiedCmp api;

  setUp(() {
    api = MockMethodChannelSourcepointUnifiedCmp();
  });

  test('loadMessage', () async {
    when(api.loadMessage(null)).thenAnswer((_) async => SPConsent());
    final consent = await api.loadMessage(null);
    expect(consent, isNotNull);
  });
}
