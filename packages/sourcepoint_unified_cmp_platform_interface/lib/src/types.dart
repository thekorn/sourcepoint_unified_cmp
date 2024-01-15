// ignore_for_file: public_member_api_docs

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

enum PMTab { purposes }

enum CampaignType { gdpr, ccpa }

enum MessageType { mobile, ott, lagazyOtt }

enum GranularState { all, some, none }

class GDPRPurposeGrants {
  GDPRPurposeGrants({required this.granted, required this.purposeGrants});
  final bool granted;
  final Map<String, bool> purposeGrants;

  @override
  String toString() {
    return 'GDPRPurposeGrants(granted: $granted, '
        'purposeGrants: $purposeGrants)';
  }
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

  @override
  String toString() {
    return 'GranularStatus(defaultConsent: $defaultConsent, '
        'previousOptInAll: $previousOptInAll, purposeConsent: $purposeConsent, '
        'purposeLegInt: $purposeLegInt, vendorConsent: $vendorConsent, '
        'vendorLegInt: $vendorLegInt)';
  }
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

  @override
  String toString() {
    return 'ConsentStatus(consentedAll: $consentedAll, '
        'consentedToAny: $consentedToAny, granularStatus: $granularStatus, '
        'hasConsentData: $hasConsentData, rejectedAny: $rejectedAny, '
        'rejectedLI: $rejectedLI, legalBasisChanges: $legalBasisChanges, '
        'vendorListAdditions: $vendorListAdditions)';
  }
}

class GDPRConsent {
  GDPRConsent({
    required this.tcData,
    required this.grants,
    required this.euconsent,
    required this.acceptedCategories,
    required this.apply,
    this.consentStatus,
    this.uuid,
  });
  final String? uuid;
  final Map<String, String> tcData;
  final Map<String, GDPRPurposeGrants> grants;
  final String euconsent;
  final List<String> acceptedCategories;
  final bool apply;
  final ConsentStatus? consentStatus;

  @override
  String toString() {
    return 'GDPRConsent(tcData: $tcData, grants: $grants, '
        'euconsent: $euconsent, acceptedCategories: $acceptedCategories, '
        'apply: $apply, consentStatus: $consentStatus, uuid: $uuid)';
  }
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
  final List<String> rejectedCategories;
  final List<String> rejectedVendors;
  final String? status;
  final String uspstring;
  final bool apply;
}

class SPConsent {
  SPConsent({this.gdpr, this.ccpa});
  final GDPRConsent? gdpr;
  final CCPAConsent? ccpa;

  @override
  String toString() {
    return 'SPConsent(gdpr: $gdpr, ccpa: $ccpa)';
  }
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

enum ActionType {
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

enum SourcepointUnifiedCmpError {
  invalidArgumentException,
  missingPropertyException,
  invalidConsentResponse,
  noInternetConnectionException,
  executionInTheWrongThreadException,
  requestFailedException,
  invalidRequestException
}
