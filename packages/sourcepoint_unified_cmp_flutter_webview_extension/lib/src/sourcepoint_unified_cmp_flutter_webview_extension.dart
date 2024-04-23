// ignore_for_file: prefer_single_quotes, avoid_escaping_inner_quotes, lines_longer_than_80_chars, public_member_api_docs

import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _eventSPPreload = 'sp.loadConsent';
const _eventSPReady = 'sp.readyForConsent';

extension SourcepointUnifiedCmpWebViewController on WebViewController {
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
