import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

const _eventSPPreload = 'sp.loadConsent';
const _eventSPReady = 'sp.readyForConsent';

/// Generates a post message string for the Sourcepoint Unified CMP Flutter
/// WebView Extension.
///
/// Parameters:
/// - `consent`: The SPConsent object containing the consent information.
///
/// Returns:
/// A string representing the post message.
String generatePostMessageString(SPConsent consent) {
  return '''
    window.postMessage({
        name: "$_eventSPPreload",
        consent: ${consent.webConsents}
    }, "*")
  '''
      .trim();
}

/// Generates a JavaScript string based on the given [postMessageString].
///
/// This function is used to generate a JavaScript string that can be executed
/// in a webview.
/// It takes a [postMessageString] as input and returns a JavaScript string.
/// The generated JavaScript string can be used to communicate with the webview.
///
/// Note: The generated JavaScript string should be executed in a webview
/// context.
String generateJSString(String postMessageString) {
  return """
        $postMessageString
        window.addEventListener('message', (event) => {
            if (event && event.data && event.data.name === "$_eventSPReady") {
                $postMessageString
            }
        })
    """
      .trim();
}

/// Generates a JavaScript string to preload consent data into a web view.
///
/// This function takes an [SPConsent] object and converts it into a JavaScript
/// string that can be injected into a web view to preload the consent data.
///
/// - Parameter consent: An [SPConsent] object containing the consent data.
/// - Returns: A JavaScript string that preloads the consent data.
String generatePreloadJSString(SPConsent consent) {
  assert(consent.webConsents != null, 'webConsents cannot be null');
  final postMessageString = generatePostMessageString(consent);

  return generateJSString(postMessageString);
}
