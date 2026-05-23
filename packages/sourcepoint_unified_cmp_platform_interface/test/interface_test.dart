import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';

// Minimal concrete subclass to exercise base class methods.
class _TestPlatform extends SourcepointUnifiedCmpPlatform {}

// Minimal concrete delegate with all-null callbacks.
class _TestDelegate extends SourcepointEventDelegatePlatform {
  _TestDelegate() : super();
}

class _TestConsentChangeNotifier extends ConsentChangeNotifier {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('default instance is MethodChannelSourcepointUnifiedCmp', () {
    expect(
      SourcepointUnifiedCmpPlatform.instance,
      isA<MethodChannelSourcepointUnifiedCmp>(),
    );
  });

  group('SourcepointUnifiedCmpPlatform base class', () {
    late _TestPlatform platform;

    setUp(() {
      platform = _TestPlatform();
    });

    tearDown(() {
      SourcepointUnifiedCmpPlatform.setInstanceUnverified(
        MethodChannelSourcepointUnifiedCmp(),
      );
    });

    test('registerEventDelegate throws UnimplementedError', () {
      expect(
        () => platform.registerEventDelegate(_TestDelegate()),
        throwsUnimplementedError,
      );
    });

    test('registerConsentChangeNotifier throws UnimplementedError', () {
      expect(
        () => platform.registerConsentChangeNotifier(
          _TestConsentChangeNotifier(),
        ),
        throwsUnimplementedError,
      );
    });

    test('loadMessage throws UnimplementedError', () {
      expect(
        () => platform.loadMessage(
          SPConfig(
            accountId: 22,
            propertyId: 7639,
            propertyName: 'test',
            pmId: '123',
            campaigns: [CampaignType.gdpr],
          ),
        ),
        throwsUnimplementedError,
      );
    });

    test('loadPrivacyManager throws UnimplementedError', () {
      expect(
        () => platform.loadPrivacyManager(
          '123',
          PMTab.purposes,
          CampaignType.gdpr,
          MessageType.mobile,
        ),
        throwsUnimplementedError,
      );
    });

    test('setInstanceUnverified sets the platform instance', () {
      final testPlatform = _TestPlatform();
      SourcepointUnifiedCmpPlatform.setInstanceUnverified(testPlatform);
      expect(SourcepointUnifiedCmpPlatform.instance, testPlatform);
    });

    test('instance setter verifies token and sets the instance', () {
      final testPlatform = _TestPlatform();
      // Using the verified setter requires the class to have been constructed
      // via SourcepointUnifiedCmpPlatform, which _TestPlatform is.
      SourcepointUnifiedCmpPlatform.instance = testPlatform;
      expect(SourcepointUnifiedCmpPlatform.instance, testPlatform);
    });
  });

  group('SourcepointEventDelegatePlatform', () {
    test('creates with all null callbacks by default', () {
      final delegate = _TestDelegate();
      expect(delegate.onConsentReady, isNull);
      expect(delegate.onUIFinished, isNull);
      expect(delegate.onUIReady, isNull);
      expect(delegate.onError, isNull);
      expect(delegate.onAction, isNull);
      expect(delegate.onNoIntentActivitiesFound, isNull);
      expect(delegate.onSpFinished, isNull);
    });
  });
}
