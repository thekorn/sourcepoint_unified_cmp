import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _eventSPPreload = 'sp.loadConsent';
const _eventSPReady = 'sp.readyForConsent';

/// Extension on [WebViewController] to provide additional functionality for
/// Sourcepoint Unified CMP.
/// This extension adds a method to inject the [SPConsent] to the
/// [WebViewController] class.
extension SourcepointUnifiedCmpWebViewController on WebViewController {
  /// Preloads the consent for the Sourcepoint Unified CMP Flutter WebView.
  ///
  /// This method asynchronously preloads the Sourcepoint Unified Consent.
  /// The [consent] parameter is required and represents the consent to be
  /// preloaded.
  ///
  /// Throws an exception if an error occurs during the preloading process.
  Future<void> preloadConsent({required SPConsent consent}) async {
    assert(consent.webConsents != null, 'webConsents cannot be null');
    final postMessageString = '''
        window.postMessage({
            name: "$_eventSPPreload",
            consent: ${consent.webConsents}
        }, "*")
    '''
        .trim();

    final jsString = """
        $postMessageString
        window.addEventListener('message', (event) => {
            if (event && event.data && event.data.name === "$_eventSPReady") {
                $postMessageString
            }
        })
    """
        .trim();
    await runJavaScript(jsString);
  }
}
