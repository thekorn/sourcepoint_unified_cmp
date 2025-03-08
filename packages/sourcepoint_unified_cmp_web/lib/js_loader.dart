import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

@JS('_sp_')
external set exportedConfig(JSObject value);

@JS('_sp_.loadPrivacyManagerModal')
external void _loadPrivacyManagerModal(int id);

@JSExport()
class SPWebEvents {
  SPWebEvents();

  void onMessageReady() {
    print('onMessageReady YEAH ');
  }

  void onMessageChoiceSelect(
    int choice_id,
    int choice_type_id,
  ) {
    print(
      'onMessageChoiceSelect choice_id: $choice_id',
    );
    print(
      'onMessageChoiceSelect choice_id: $choice_type_id',
    );
  }

  void onPrivacyManagerAction(JSObject pmData) {
    print('onPrivacyManagerAction: ${pmData.dartify()}');
  }

  void onMessageChoiceError(JSObject err) {
    print('onMessageChoiceError: $err');
  }

  void onConsentReady(String consentUUID, String euconsent) {
    print('onConsentReady');
    print('consentUUID: $consentUUID');
    print('euconsent: $euconsent');
  }

  void onPMCancel() {
    print('onPMCancel');
  }

  void onMessageReceiveData(JSObject data) {
    print('onMessageReceiveData: $data');
    //print(JSON.stringify(data));
  }

  void onSPPMObjectReady() {
    print('onSPPMObjectReady YEAH 1111');
    _loadPrivacyManagerModal(122058);
  }
}

@JSExport()
class SPInnerWebConfig {
  int accountId;
  String baseEndpoint = 'https://cdn.privacy-mgmt.com';
  Object gdpr = {};
  int propertyId = 7639;
  String propertyName = 'tcfv2.mobile.webview';
  JSObject events = createJSInteropWrapper(SPWebEvents());

  SPInnerWebConfig(this.accountId);
}

// Export the class so it is accessible in JavaScript
@JSExport()
class SPWebConfig {
  SPInnerWebConfig config;

  SPWebConfig(this.config);
}

// The URL from which the script should be downloaded.
// TODO(mkorn): allow overwrite
const String _url =
    'https://cdn.privacy-mgmt.com/wrapperMessagingWithoutDetection.js';

// TODO(mkorn): allow overwrite
String _sourcepointStub =
// ignore: lines_longer_than_80_chars
    'function _typeof(t){return(_typeof="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t})(t)}!function(){for(var t,e,o=[],n=window,r=n;r;){try{if(r.frames.__tcfapiLocator){t=r;break}}catch(t){}if(r===n.top)break;r=n.parent}t||(function t(){var e=n.document,o=!!n.frames.__tcfapiLocator;if(!o)if(e.body){var r=e.createElement("iframe");r.style.cssText="display:none",r.name="__tcfapiLocator",e.body.appendChild(r)}else setTimeout(t,5);return!o}(),n.__tcfapi=function(){for(var t=arguments.length,n=new Array(t),r=0;r<t;r++)n[r]=arguments[r];if(!n.length)return o;"setGdprApplies"===n[0]?n.length>3&&2===parseInt(n[1],10)&&"boolean"==typeof n[3]&&(e=n[3],"function"==typeof n[2]&&n[2]("set",!0)):"ping"===n[0]?"function"==typeof n[2]&&n[2]({gdprApplies:e,cmpLoaded:!1,cmpStatus:"stub"}):o.push(n)},n.addEventListener("message",(function(t){var e="string"==typeof t.data,o={};if(e)try{o=JSON.parse(t.data)}catch(t){}else o=t.data;var n="object"===_typeof(o)?o.__tcfapiCall:null;n&&window.__tcfapi(n.command,n.version,(function(o,r){var a={__tcfapiReturn:{returnValue:o,success:r,callId:n.callId}};t&&t.source&&t.source.postMessage&&t.source.postMessage(e?JSON.stringify(a):a,"*")}),n.parameter)}),!1))}();';

String _loadScript = '''
    window._sp_ = {
        config: {
            accountId: 22,
            baseEndpoint: "https://cdn.privacy-mgmt.com",
            gdpr: {},
            propertyId: 7639,
            propertyName: "tcfv2.mobile.webview",
            events: {
                onMessageReady: function () {
                    console.log("onMessageReady");
                },
                onMessageChoiceSelect: function (
                    choice_id,
                    choice_type_id,
                ) {
                    console.log(
                        "onMessageChoiceSelect choice_id: ",
                        choice_id,
                    );
                    console.log(
                        "onMessageChoiceSelect choice_id: ",
                        choice_type_id,
                    );
                },
                onPrivacyManagerAction: function (pmData) {
                    console.log("onPrivacyManagerAction", pmData);
                },
                onMessageChoiceError: function (err) {
                    console.log("onMessageChoiceError", err);
                },
                onConsentReady: function (consentUUID, euconsent) {
                    console.log("onConsentReady");
                    console.log("consentUUID", consentUUID);
                    console.log("euconsent", euconsent);
                },
                onPMCancel: function () {
                    console.log("onPMCancel");
                },
                onMessageReceiveData: function (data) {
                    console.log("onMessageReceiveData", data);
                    console.log(JSON.stringify(data));
                },
                onSPPMObjectReady: function () {
                    console.log(
                        "onSPPMObjectReady",
                    );
                    //debugger;
                    window._sp_.loadPrivacyManagerModal(122058);
                },
            },
        },
    };
''';

Future<void> loadWebSdk() async {
  final completer = Completer<void>();

  final config = SPWebConfig(SPInnerWebConfig(11111));

  final export = createJSInteropWrapper(config);
  exportedConfig = export;
  //final loadScript = web.HTMLScriptElement()..text = _loadScript;
  //web.document.body?.appendChild(loadScript);

  final stubScript = web.HTMLScriptElement()..text = _sourcepointStub;
  web.document.head?.appendChild(stubScript);

  final script = web.HTMLScriptElement()
    ..async = true
    ..defer = true
    ..src = _url
    ..onLoad.listen((web.Event event) {
      completer.complete();
    });

  web.document.head?.appendChild(script);

  return completer.future;
}
