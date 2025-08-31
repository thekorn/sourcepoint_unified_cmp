import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_inappwebview_extension/sourcepoint_unified_cmp_flutter_inappwebview_extension.dart';

@GenerateNiceMocks([MockSpec<PlatformInAppWebViewController>()])
import 'sourcepoint_unified_cmp_flutter_inappwebview_extension_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test(
    'preloadConsent should run the correct JavaScript in the webview',
    () async {
      final consent = SPConsent(webConsents: 'bla');

      final mockPlatformWebViewController =
          MockPlatformInAppWebViewController();

      final webViewController = InAppWebViewController.fromPlatform(
        platform: mockPlatformWebViewController,
      );

      await webViewController.preloadConsent(consent: consent);
      verify(
        mockPlatformWebViewController.evaluateJavascript(
          source: captureAnyNamed('source'),
        ),
      );
    },
  );

  test(
    'preloadConsent should raise an assertion if webConsents is null',
    () async {
      // ignore: avoid_redundant_argument_values
      final consent = SPConsent(webConsents: null);

      final mockPlatformWebViewController =
          MockPlatformInAppWebViewController();

      final webViewController = InAppWebViewController.fromPlatform(
        platform: mockPlatformWebViewController,
      );

      expect(
        () async => webViewController.preloadConsent(consent: consent),
        throwsAssertionError,
      );
    },
  );
}
