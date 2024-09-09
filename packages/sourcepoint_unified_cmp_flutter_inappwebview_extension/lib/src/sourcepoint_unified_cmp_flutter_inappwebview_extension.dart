import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

/// Extension on [InAppWebViewController] to provide additional functionality
/// for Sourcepoint Unified CMP.
/// This extension adds a method to inject the [SPConsent] to the
/// [InAppWebViewController] class.
extension SourcepointUnifiedCmpInAppWebViewController
    on InAppWebViewController {
  /// Preloads the consent for the Sourcepoint Unified CMP Flutter InAppWebView.
  ///
  /// This method asynchronously preloads the Sourcepoint Unified Consent.
  /// The [consent] parameter is required and represents the consent to be
  /// preloaded.
  ///
  /// Throws an exception if an error occurs during the preloading process.
  Future<void> preloadConsent({required SPConsent consent}) async {
    assert(consent.webConsents != null, 'webConsents cannot be null');
    final postMessageString = generatePostMessageString(consent);

    final jsString = generateJSString(postMessageString);
    await evaluateJavascript(source: jsString);
  }
}
