# sourcepoint unified cmp - flutter inappwebview extension

![sourcepoint_unified_cmp workflow](https://github.com/thekorn/sourcepoint_unified_cmp/actions/workflows/sourcepoint_unified_cmp.yaml/badge.svg) ![ci workflow](https://github.com/thekorn/sourcepoint_unified_cmp/actions/workflows/ci.yaml/badge.svg) [![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=thekorn_sourcepoint_unified_cmp&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=thekorn_sourcepoint_unified_cmp)

This is integrating the flutter integration for sourcepoint's unified CMP with the flutter_inappwebview package.
This package provides a single extension method `preloadConsent()` to the `InAppWebViewController` to inject the
consent given in "flutter land" into the inappwebview.

## Contributing to the project

Please the [CONTRIBUTING.md](https://github.com/thekorn/sourcepoint_unified_cmp/blob/main/CONTRIBUTING.md) for details.

## example usage:

In order to use this extension please make sure to implement `sourcepoint_unified_cmp` in your project - for further tasks please check the [sourcepoint_unified_cmp](https://pub.dev/packages/sourcepoint_unified_cmp) package.


### sample code:

For a running examples please check the sample app at [example/lib/main.dart](https://github.com/thekorn/sourcepoint_unified_cmp/blob/main/packages/sourcepoint_unified_cmp_flutter_inappwebview_extension/example/lib/main.dart) - the sample app can be run using `melos run run:example:flutter_inappwebview -- -d sdk` (android) or `melos run run:example:flutter_inappwebview -- -d IPhone` (ios).

Important bits of the implementation are:

Import the sourcepoint unified cmp and the flutter_inappwebview package and the extension to the webview
```dart
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_flutter_inappwebview_extension/sourcepoint_unified_cmp_flutter_inappwebview_extension.dart';
```

Initialize and configure the sourcepoint controller

```dart
    final config = SPConfig(
      accountId: 22,
      propertyId: 31007,
      propertyName: 'sdks-auth-consent-test-page',
      pmId: '122058',
      campaigns: [CampaignType.gdpr],
    );

    _controller = SourcepointController(config: config)
      ..setEventDelegate(
        SourcepointEventDelegate(
          onConsentReady: (SPConsent consent) {
            debugPrint('DELEGATE onConsentReady: Consent string: '
                '${consent.gdpr?.euconsent}');
          },
          onSpFinished: (SPConsent consent) {
            debugPrint(
              'DELEGATE SpFinished: Consent string: ${consent.gdpr?.euconsent}',
            );
          },
        ),
      );
```

Once a site is loaded in the webview, the consent can be injected using the `preloadConsent()` method on the `InAppWebViewController` - consent has to be obtained before using the sourcepoint unified cmp package.

```dart
return InAppWebView(
  initialUrlRequest: URLRequest(
    url: WebUri(
      'https://sourcepointusa.github.io/sdks-auth-consent-test-page/?_sp_version=4.9.0&_sp_pass_consent=true',
    ),
  ),
  onWebViewCreated: (controller) {
    _webViewController = controller;
  },
  onLoadStop: (controller, url) async {
    await _webViewController.preloadConsent(consent: consent!);
  },
);
```

**Important:** the web page needs to implement the sourcepoint unified cmp script and the `?_sp_version=4.9.0&_sp_pass_consent=true` has to be used in order to instruct the js sdk to listen for `external` consent.

**Result:**

![](https://github.com/thekorn/sourcepoint_unified_cmp/raw/main/doc/images/webview-ios.gif)
