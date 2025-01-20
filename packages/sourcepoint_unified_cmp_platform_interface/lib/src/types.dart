/// Represents the language used in the privacy manager.
enum MessageLanguage {
  /// English
  english,

  /// French
  french,

  /// German
  german,

  /// Italian
  italian,

  /// Spanish
  spanish,

  /// Dutch
  dutch,
}

/// Sourcepoint campaign environment.
enum CampaignsEnv {
  /// Stage
  stage,

  /// Public
  public
}

/// Represents the configuration for Sourcepoint Unified CMP.
/// Use the factory method to obtain a lazy configuration for v6 (Unified SDK).
/// This contains your organization's account information and includes the type
/// of campaigns that will be run on this property. This object will be
/// instantiated at the first usage of the CMP SDK.
/// The config object is a simple DTO.
class SPConfig {
  // ignore: public_member_api_docs
  SPConfig({
    required this.accountId,
    required this.propertyId,
    required this.propertyName,
    required this.pmId,
    required this.campaigns,
    this.messageLanguage = MessageLanguage.english,
    this.campaignsEnv = CampaignsEnv.public,
    this.messageTimeout = 30000,
  });

  /// The account ID associated with the source point.
  final int accountId;

  /// The ID of the property.
  final int propertyId;

  /// The name of the property.
  final String propertyName;

  /// The unique identifier for a privacy manager.
  final String pmId;

  /// The [MessageLanguage] used in the privacy manager.
  final MessageLanguage messageLanguage;

  /// The sourcepoint [CampaignsEnv] the privacy manager is run in.
  final CampaignsEnv campaignsEnv;

  /// The timeout duration for displaying a message.
  final int messageTimeout;

  /// Represents a list of campaign types.
  ///
  /// The [campaigns] property holds a list of [CampaignType] objects.
  final List<CampaignType> campaigns;
}

/// Selected tab within the privacy manager.
enum PMTab {
  /// purposes tab
  purposes,

  /// default tab
  defaults,

  /// vendors tab
  vendors,

  /// features tab
  features,
}

/// Consent categories.
enum CampaignType {
  /// Used if your property runs a GDPR TCF or GDPR Standard campaign
  gdpr,

  /// Used if your property runs a U.S. Privacy (Legacy) campaign
  ccpa,

  /// Represents the United States National Advertising Initiative (USNAT).
  usnat,

  /// Used if your property runs a U.S. Multi-State Privacy campaign.
  /// Please do not attempt to utilize both CCPA and USNAT simultaneously as
  /// this poses a compliance risk for your organization.
  ///
  /// This campaign type should only be implemented via the config object on
  /// mobile devices. Click here to learn more about implementing U.S.
  /// Multi-State Privacy on OTT.
  ///usnat
  // TODO(thekorn): add missing iOs specific campaigns
}

/// message type - android only
enum MessageType {
  /// MOBILE: it is used for mobile devices
  mobile,

  /// OTT: it presents a new layout and operates on TV devices
  ott,

  /// LEGACY_OTT: it presents the legacy layout and operates on TV devices.
  legacyOtt
}

// ignore: public_member_api_docs
enum GranularState { all, some, none, emptyVl }

/// Represents the GDPR purpose grants.
class GDPRPurposeGrants {
  // ignore: public_member_api_docs
  GDPRPurposeGrants({required this.granted, required this.purposeGrants});

  /// Indicates whether the user has granted consent for all purposes.
  final bool granted;

  /// detailed grants per purpose
  final Map<String, bool> purposeGrants;

  @override
  String toString() {
    return 'GDPRPurposeGrants(granted: $granted, '
        'purposeGrants: $purposeGrants)';
  }
}

/// Represents the granular status of a component.
class GranularStatus {
  // ignore: public_member_api_docs
  GranularStatus({
    this.defaultConsent,
    this.previousOptInAll,
    this.purposeConsent,
    this.purposeLegInt,
    this.vendorConsent,
    this.vendorLegInt,
  });

  /// Indicates whether the user has granted consent for all purposes.
  final bool? defaultConsent;

  /// Indicates whether the user has granted consent for all purposes.
  final bool? previousOptInAll;

  /// [GranularState] for purpose consent
  final GranularState? purposeConsent;

  /// [GranularState] for purpose legitimate interest
  final GranularState? purposeLegInt;

  /// [GranularState] for vendor consent
  final GranularState? vendorConsent;

  /// [GranularState] for vendor legitimate interest
  final GranularState? vendorLegInt;

  @override
  String toString() {
    return 'GranularStatus(defaultConsent: $defaultConsent, '
        'previousOptInAll: $previousOptInAll, purposeConsent: $purposeConsent, '
        'purposeLegInt: $purposeLegInt, vendorConsent: $vendorConsent, '
        'vendorLegInt: $vendorLegInt)';
  }
}

/// represents the detailed consent status
class ConsentStatus {
  // ignore: public_member_api_docs
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

  /// Indicates whether the user has granted consent for all purposes.
  final bool? consentedAll;

  /// Indicates whether the user has granted consent for any purpose.
  final bool? consentedToAny;

  /// [GranularState] for purpose consent
  final GranularStatus? granularStatus;

  /// Indicates whether the user has consent data.
  final bool? hasConsentData;

  /// Indicates whether the user has rejected consent for any purpose.
  final bool? rejectedAny;

  /// Indicates whether the user has rejected consent for any
  /// legitimate interest.
  final bool? rejectedLI;

  // TODO(thekorn): document, purpose of this field is unclear

  /// Indicates whether the legal basis has changed.
  final bool? legalBasisChanges;

  // TODO(thekorn): document, purpose of this field is unclear

  /// Indicates whether the vendor list has additions.
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

/// Represents the GDPR consent.
class GDPRConsent {
  // ignore: public_member_api_docs
  GDPRConsent({
    required this.tcData,
    required this.grants,
    required this.euconsent,
    required this.acceptedCategories,
    required this.apply,
    this.consentStatus,
    this.uuid,
  });

  /// The unique identifier for a given consent
  final String? uuid;

  /// The TCData object
  final Map<String, String> tcData;

  /// The [GDPRPurposeGrants] per vendor
  final Map<String, GDPRPurposeGrants> grants;

  /// The euconsent string
  final String euconsent;

  /// The list of accepted categories
  final List<String> acceptedCategories;

  /// Indicates whether the consent should be applied
  final bool apply;

  /// The [ConsentStatus] object
  final ConsentStatus? consentStatus;

  @override
  String toString() {
    return 'GDPRConsent(tcData: $tcData, grants: $grants, '
        'euconsent: $euconsent, acceptedCategories: $acceptedCategories, '
        'apply: $apply, consentStatus: $consentStatus, uuid: $uuid)';
  }
}

/// Represents the CCPA (California Consumer Privacy Act) consent.
class CCPAConsent {
  // ignore: public_member_api_docs
  CCPAConsent({
    required this.rejectedCategories,
    required this.rejectedVendors,
    required this.uspstring,
    required this.apply,
    this.uuid,
    this.status,
  });

  /// The unique identifier for a given consent
  final String? uuid;

  /// The list of rejected categories
  final List<String> rejectedCategories;

  /// The list of rejected vendors
  final List<String> rejectedVendors;

  /// The status of the consent
  final String? status;

  /// The USP string
  final String uspstring;

  /// Indicates whether the consent should be applied
  final bool apply;
}

/// The SpConsent object contains all the info related with the user consent
/// action.
///
/// SpConsent
///    |-- gdpr?
///    |   |-- uuid: String?
///    |   |-- tcData: Map<String, String>
///    |   |-- grants: Map<String, GDPRPurposeGrants>
///    |   |-- euconsent: String
///    |   |-- acceptedCategories: List<String>
///    |   |-- apply: Boolean
///    |   |-- consentStatus: ConsentStatus
///    |-- ccpa?
///        |-- uuid: String?
///        |-- rejectedCategories: List<String>
///        |-- rejectedVendors: List<String>
///        |-- status: String?
///        |-- uspstring: String
///        |-- apply: Boolean
class SPConsent {
  // ignore: public_member_api_docs
  SPConsent({this.gdpr, this.ccpa, this.webConsents});

  /// The GDPR consent
  final GDPRConsent? gdpr;

  /// The CCPA consent
  final CCPAConsent? ccpa;

  /// consent representations which is injectable to webview
  final String? webConsents;

  @override
  String toString() {
    return 'SPConsent(gdpr: $gdpr, ccpa: $ccpa, webConsents: $webConsents)';
  }
}

/// Represents a consent action.
/// The [ConsentAction] contains
/// ConsentAction
/// |-- actionType: ActionType
/// |-- pubData: JSONObject
/// |-- campaignType: CampaignType
/// |-- customActionId: String?
class ConsentAction {
  // ignore: public_member_api_docs
  ConsentAction({
    required this.actionType,
    required this.pubData,
    required this.campaignType,
    this.customActionId,
  });

  /// [ActionType] of the consent action
  final ActionType actionType;

  /// JSONObject object, it is used to send custom parameters to our BE
  final dynamic pubData;

  /// campaign type associated with the selected action
  final CampaignType campaignType;

  /// nullable field which returns the custom id set along with the custom
  /// action from our web message builder
  final String? customActionId;
}

/// Action emitted by the privacy manager
enum ActionType {
  /// show options button has been clicked
  showOptions,

  /// reject all button has been clicked
  rejectAll,

  /// accept all button has been clicked
  acceptAll,

  /// cancel button has been clicked
  msgCancel,

  /// custom CTA button has been clicked
  custom,

  /// save and exit button has been clicked
  saveAndExit,

  /// privacy manager has been dismissed
  pmDismiss,

  /// message error - ios only
  getMsgError,

  /// message ready - ios only
  getMessageNotCalled,

  /// unknown action - ios only
  unknown,
}

/// Represents an error that can occur in the Sourcepoint Unified CMP platform
/// interface.
class SPError {
  // ignore: public_member_api_docs
  SPError({
    required this.spCode,
    required this.description,
  });

  /// short representation of the error
  final String spCode;

  /// longer, end-user friendly description of the error
  final String description;

  @override
  String toString() {
    return 'SPError(spCode: $spCode, description: $description)';
  }
}
