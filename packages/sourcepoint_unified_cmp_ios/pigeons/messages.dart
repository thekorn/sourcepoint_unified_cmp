// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

enum HostAPIPMTab { defaults, purposes, vendors, features }

enum HostAPICampaignType { gdpr, ccpa }

enum HostAPIMessageType { mobile, ott, legacyOtt }

enum HostAPIGranularState { all, some, none }

enum HostAPIActionType {
  showOptions,
  rejectAll,
  acceptAll,
  msgCancel,
  custom,
  saveAndExit,
  pmDismiss,
  getMsgError,
  getMessageNotCalled,
  unknown,
}

class HostAPISPError {
  HostAPISPError({required this.spCode, required this.description});
  final String spCode;
  final String description;
}

enum HostAPIMessageLanguage { english, french, german, italian, spanish, dutch }

//FIXME: publicEnv is used because public is reserved in swift
//  needs to be unified with android version if we want to put those in a
//  central place
enum HostAPICampaignsEnv { stage, publicEnv }

class HostAPIConsentAction {
  HostAPIConsentAction({
    required this.actionType,
    required this.pubData,
    required this.campaignType,
    this.customActionId,
  });
  final HostAPIActionType actionType;
  final String pubData;
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
  HostAPISPConsent({this.gdpr, this.ccpa, this.webConsents});
  final HostAPIGDPRConsent? gdpr;
  final HostAPICCPAConsent? ccpa;
  final String? webConsents;
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
    swiftOut: 'ios/Classes/pigeons/SourcepointUnifiedCmp.g.swift',
    swiftOptions: SwiftOptions(errorClassName: 'HostApiFlutterError'),
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
    required HostAPIMessageLanguage messageLanguage,
    required HostAPICampaignsEnv campaignsEnv,
    required int messageTimeout,
    required bool runGDPRCampaign,
    required bool runCCPACampaign,
  });

  @async
  void loadPrivacyManager({
    required String pmId,
    required HostAPIPMTab pmTab,
    required HostAPICampaignType campaignType,
    required HostAPIMessageType messageType,
  });
}

@FlutterApi()
abstract class SourcepointUnifiedCmpFlutterApi {
  void onUIFinished() {}
  void onUIReady() {}
  void onError(HostAPISPError error) {}
  void onConsentReady(HostAPISPConsent consent) {}
  void onAction(HostAPIConsentAction consentAction) {}
  void onNoIntentActivitiesFound(String url) {}
  void onSpFinished(HostAPISPConsent consent) {}
}
