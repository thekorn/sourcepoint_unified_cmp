// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

enum PMTab { purposes }

enum CampaignType { gdpr, ccpa }

enum MessageType { mobile, ott, lagazyOtt }

enum GranularState { all, some, none }

enum ActionType {
  showOptions,
  rejectAll,
  acceptAll,
  msgCancel,
  custom,
  saveAndExit,
  pmDismiss,
}

enum SourcepointUnifiedCmpError {
  invalidArgumentException,
  missingPropertyException,
  invalidConsentResponse,
  noInternetConnectionException,
  executionInTheWrongThreadException,
  requestFailedException,
  invalidRequestException
}

class ConsentAction {
  ConsentAction({
    required this.actionType,
    required this.pubData,
    required this.campaignType,
    this.customActionId,
  });
  final ActionType actionType;
  final Object pubData;
  final CampaignType campaignType;
  final String? customActionId;
}

class GDPRPurposeGrants {
  GDPRPurposeGrants({required this.granted, required this.purposeGrants});
  final bool granted;
  final Map<String?, bool?>? purposeGrants;
}

class GranularStatus {
  GranularStatus({
    this.defaultConsent,
    this.previousOptInAll,
    this.purposeConsent,
    this.purposeLegInt,
    this.vendorConsent,
    this.vendorLegInt,
  });
  final bool? defaultConsent;
  final bool? previousOptInAll;
  final GranularState? purposeConsent;
  final GranularState? purposeLegInt;
  final GranularState? vendorConsent;
  final GranularState? vendorLegInt;
}

class ConsentStatus {
  ConsentStatus({
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
  final GranularStatus? granularStatus;
  final bool? hasConsentData;
  final bool? rejectedAny;
  final bool? rejectedLI;
  final bool? legalBasisChanges;
  final bool? vendorListAdditions;
}

class GDPRConsent {
  GDPRConsent({
    required this.tcData,
    required this.grants,
    required this.euconsent,
    required this.acceptedCategories,
    required this.apply,
    required this.consentStatus,
    this.uuid,
  });
  final String? uuid;
  final Map<String?, String?>? tcData;
  final Map<String?, GDPRPurposeGrants?>? grants;
  final String euconsent;
  final List<String?>? acceptedCategories;
  final bool apply;
  final ConsentStatus consentStatus;
}

class CCPAConsent {
  CCPAConsent({
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

class SPConsent {
  SPConsent({this.gdpr, this.ccpa});
  final GDPRConsent? gdpr;
  final CCPAConsent? ccpa;
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
  bool loadMessage({
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

  void onError(SourcepointUnifiedCmpError error) {}
  void onConsentReady(SPConsent consent) {}
  void onAction(int viewId, ConsentAction consentAction) {}
  void onNoIntentActivitiesFound(String url) {}
  void onSpFinished(SPConsent consent) {}
}
