// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

enum HostAPIPMTab { purposes }

enum HostAPICampaignType { gdpr, ccpa }

enum MessageType { mobile, ott, lagazyOtt }

enum HostAPIGranularState { all, some, none }

enum HostAPIActionType {
  showOptions,
  rejectAll,
  acceptAll,
  msgCancel,
  custom,
  saveAndExit,
  pmDismiss,
}

enum HostAPISourcepointUnifiedCmpError {
  invalidArgumentException,
  missingPropertyException,
  invalidConsentResponse,
  noInternetConnectionException,
  executionInTheWrongThreadException,
  requestFailedException,
  invalidRequestException
}

class HostAPIConsentAction {
  HostAPIConsentAction({
    required this.actionType,
    required this.pubData,
    required this.campaignType,
    this.customActionId,
  });
  final HostAPIActionType actionType;
  final Object pubData;
  final HostAPICampaignType campaignType;
  final String? customActionId;
}

class HostAPIGDPRPurposeGrants {
  HostAPIGDPRPurposeGrants({
    required this.granted,
    required this.purposeGrants,
  });
  final bool granted;
  final Map<String?, bool?>? purposeGrants;
}

class HostAPIGranularStatus {
  HostAPIGranularStatus({
    this.defaultConsent,
    this.previousOptInAll,
    this.purposeConsent,
    this.purposeLegInt,
    this.vendorConsent,
    this.vendorLegInt,
  });
  final bool? defaultConsent;
  final bool? previousOptInAll;
  final HostAPIGranularState? purposeConsent;
  final HostAPIGranularState? purposeLegInt;
  final HostAPIGranularState? vendorConsent;
  final HostAPIGranularState? vendorLegInt;
}

class HostAPIConsentStatus {
  HostAPIConsentStatus({
    this.consentedAll,
    this.consentedToAny,
    this.granularStatus,
    this.hasConsentData,
    this.rejectedAny,
    this.rejectedLI,
    this.legalBasisChanges,
    this.vendorListAdditions,
  });
  final bool? consentedAll;
  final bool? consentedToAny;
  final HostAPIGranularStatus? granularStatus;
  final bool? hasConsentData;
  final bool? rejectedAny;
  final bool? rejectedLI;
  final bool? legalBasisChanges;
  final bool? vendorListAdditions;
}

class HostAPIGDPRConsent {
  HostAPIGDPRConsent({
    required this.tcData,
    required this.grants,
    required this.euconsent,
    required this.acceptedCategories,
    required this.apply,
    this.consentStatus,
    this.uuid,
  });
  final String? uuid;
  final Map<String?, String?>? tcData;
  final Map<String?, HostAPIGDPRPurposeGrants?>? grants;
  final String euconsent;
  final List<String?>? acceptedCategories;
  final bool apply;
  final HostAPIConsentStatus? consentStatus;
}

class HostAPICCPAConsent {
  HostAPICCPAConsent({
    required this.rejectedCategories,
    required this.rejectedVendors,
    required this.uspstring,
    required this.apply,
    this.uuid,
    this.status,
  });
  final String? uuid;
  final List<String?>? rejectedCategories;
  final List<String?>? rejectedVendors;
  final String? status;
  final String uspstring;
  final bool apply;
}

class HostAPISPConsent {
  HostAPISPConsent({this.gdpr, this.ccpa});
  final HostAPIGDPRConsent? gdpr;
  final HostAPICCPAConsent? ccpa;
}

class SPConfig {
  SPConfig({
    required this.accountId,
    required this.propertyId,
    required this.propertyName,
    required this.pmId,
  });
  final int accountId;
  final int propertyId;
  final String propertyName;
  final String pmId;
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    //dartTestOut: 'test/test_android_webview.g.dart',
    dartOptions: DartOptions(
      copyrightHeader: <String>[
        //'Copyright 2013 The Flutter Authors. All rights reserved.',
        //'Use of this source code is governed by a BSD-style license that ',
        //'can be found in the LICENSE file.',
      ],
    ),
    kotlinOut:
        'android/src/main/kotlin/de/thekorn/sourcepoint/unified/cmp/SourcepointUnifiedCmp.g.kt',
    kotlinOptions: KotlinOptions(),
  ),
)
@HostApi()
abstract class SourcepointUnifiedCmpHostApi {
  @async
  HostAPISPConsent loadMessage({
    required int accountId,
    required int propertyId,
    required String propertyName,
    required String pmId,
  });
}

@FlutterApi()
abstract class SourcepointUnifiedCmpFlutterApi {
  void onUIFinished(int viewId) {}
  void onUIReady(int viewId) {}

  void onError(HostAPISourcepointUnifiedCmpError error) {}
  void onConsentReady(HostAPISPConsent consent) {}
  void onAction(int viewId, HostAPIConsentAction consentAction) {}
  void onNoIntentActivitiesFound(String url) {}
  void onSpFinished(HostAPISPConsent consent) {}
}
