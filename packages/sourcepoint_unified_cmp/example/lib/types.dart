enum PMTab { purposes }

enum CampaignType { gdpr, ccpa }

enum MessageType { mobile, ott, lagazyOtt }

enum GranularState { all, some, none }

class GDPRPurposeGrants {
  GDPRPurposeGrants({required this.granted, required this.purposeGrants});
  final bool granted;
  final Map<String, bool> purposeGrants;
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
  final Map<String, String> tcData;
  final Map<String, GDPRPurposeGrants> grants;
  final String euconsent;
  final List<String> acceptedCategories;
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
}
