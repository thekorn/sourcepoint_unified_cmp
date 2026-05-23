import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';

class _TestConsentChangeNotifier extends ConsentChangeNotifier {}

class _TestDelegate extends SourcepointEventDelegatePlatform {
  _TestDelegate() : super();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MethodChannelSourcepointUnifiedCmp', () {
    late MethodChannelSourcepointUnifiedCmp channel;

    setUp(() {
      channel = MethodChannelSourcepointUnifiedCmp();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('sourcepoint_unified_cmp'),
            null,
          );
    });

    group('registerConsentChangeNotifier', () {
      test('registers a notifier without throwing', () {
        final notifier = _TestConsentChangeNotifier();
        expect(
          () => channel.registerConsentChangeNotifier(notifier),
          returnsNormally,
        );
      });

      test('throws AssertionError when called a second time', () {
        final notifier = _TestConsentChangeNotifier();
        channel.registerConsentChangeNotifier(notifier);
        expect(
          () => channel.registerConsentChangeNotifier(
            _TestConsentChangeNotifier(),
          ),
          throwsAssertionError,
        );
      });
    });

    group('registerEventDelegate', () {
      test('registers a delegate without throwing', () {
        final delegate = _TestDelegate();
        expect(() => channel.registerEventDelegate(delegate), returnsNormally);
      });

      test('throws AssertionError when called a second time', () {
        final delegate = _TestDelegate();
        channel.registerEventDelegate(delegate);
        expect(
          () => channel.registerEventDelegate(_TestDelegate()),
          throwsAssertionError,
        );
      });
    });

    group('loadPrivacyManager', () {
      test('invokes the method channel without throwing', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel('sourcepoint_unified_cmp'),
              (MethodCall methodCall) async {
                if (methodCall.method == 'loadPrivacyManager') {
                  return null;
                }
                return null;
              },
            );

        await expectLater(
          channel.loadPrivacyManager(
            '122058',
            PMTab.purposes,
            CampaignType.gdpr,
            MessageType.mobile,
          ),
          completes,
        );
      });
    });
  });
}
