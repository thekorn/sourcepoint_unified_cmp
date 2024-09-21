import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_webview_extension/sourcepoint_unified_cmp_flutter_webview_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

@GenerateNiceMocks([MockSpec<PlatformWebViewController>()])
import 'sourcepoint_unified_cmp_flutter_webview_extension_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test('preloadConsent should run the correct JavaScript in the webview',
      () async {
    final consent = SPConsent(webConsents: 'bla');

    final mockPlatformWebViewController = MockPlatformWebViewController();

    final webViewController = WebViewController.fromPlatform(
      mockPlatformWebViewController,
    );

    await webViewController.preloadConsent(consent: consent);
    verify(mockPlatformWebViewController.runJavaScript(captureAny));
  });

  test('preloadConsent should raise an assertion if webConsents is null',
      () async {
    // ignore: avoid_redundant_argument_values
    final consent = SPConsent(webConsents: null);

    final mockPlatformWebViewController = MockPlatformWebViewController();

    final webViewController = WebViewController.fromPlatform(
      mockPlatformWebViewController,
    );

    expect(
      () async => webViewController.preloadConsent(consent: consent),
      throwsAssertionError,
    );
  });
}
