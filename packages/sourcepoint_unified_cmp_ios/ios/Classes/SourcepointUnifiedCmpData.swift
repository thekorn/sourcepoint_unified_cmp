import ConsentViewController

enum NotImplementedError: Error {
  case notImplemented
}

extension SPGDPRVendorGrant {
  func toHostAPIPurposeGrants() -> HostAPIGDPRPurposeGrants {
    HostAPIGDPRPurposeGrants(granted: granted, purposeGrants: purposeGrants)
  }
}

extension ConsentStatus {
  func toHostAPIConsentStatus() -> HostAPIConsentStatus {
    HostAPIConsentStatus(
      consentedAll: consentedAll,
      consentedToAny: consentedToAny,
      granularStatus: nil, /// NOTE: granularStatus is not public in the ios sdk
      hasConsentData: nil, /// NOTE: hasConsentData is not public in the ios sdk
      rejectedAny: rejectedAny,
      rejectedLI: rejectedLI,
      legalBasisChanges: legalBasisChanges,
      vendorListAdditions: vendorListAdditions
    )
  }
}

extension SPConsent {
  func toHostAPIGDPRConsent() throws -> HostAPIGDPRConsent {
    if let value = self as? SPConsent<SPGDPRConsent> {
      let tcData: [String?: String?]? = value.consents!.tcfData?.dictionaryValue?
        .reduce(into: [:]) { result, pair in
          let value: String? = (pair.value as? String) ??
            (pair.value as? CustomStringConvertible)?.description
          result[pair.key] = value
        }

      let grants: [String?: HostAPIGDPRPurposeGrants?]? = value.consents?.vendorGrants
        .reduce(into: [:]) { result, pair in
          let value: SPGDPRVendorGrant = pair.value as SPGDPRVendorGrant
          result[pair.key] = value.toHostAPIPurposeGrants()
        }

      return HostAPIGDPRConsent(
        uuid: value.consents!.uuid,
        tcData: tcData,
        grants: grants,
        euconsent: value.consents!.euconsent,
        acceptedCategories: value.consents!.acceptedCategories,
        apply: value.consents!.applies,
        consentStatus: value.consents!.consentStatus.toHostAPIConsentStatus()
      )
    } else {
      throw NotImplementedError.notImplemented
    }
  }
}

func encodeWebConsents(webConsents: SPWebConsents) -> String? {
  guard let consentsData = try? JSONEncoder().encode(webConsents) else { return nil }
  return String(data: consentsData, encoding: .utf8)
}

extension SPUserData {
  func toHostAPISPConsent() -> HostAPISPConsent {
    HostAPISPConsent(
      gdpr: try? gdpr?.toHostAPIGDPRConsent(),
      webConsents: encodeWebConsents(webConsents: webConsents)
    )
  }
}

extension HostAPICampaignsEnv {
  func toSPCampaignEnv() -> SPCampaignEnv {
    switch self {
    case .stage:
      SPCampaignEnv.Stage
    case .publicEnv:
      SPCampaignEnv.Public
    }
  }
}

extension HostAPIMessageLanguage {
  func toSPMessageLanguage() -> SPMessageLanguage {
    switch self {
    case .german:
      SPMessageLanguage.German
    case .english:
      SPMessageLanguage.English
    case .french:
      SPMessageLanguage.French
    case .italian:
      SPMessageLanguage.Italian
    case .spanish:
      SPMessageLanguage.Spanish
    }
  }
}

extension HostAPIPMTab {
  func toSPPrivacyManagerTab() -> SPPrivacyManagerTab {
    switch self {
    case .purposes:
      SPPrivacyManagerTab.Purposes
    case .defaults:
      SPPrivacyManagerTab.Default
    case .vendors:
      SPPrivacyManagerTab.Vendors
    case .features:
      SPPrivacyManagerTab.Features
    }
  }
}

extension SPAction {
  func toHostAPIConsentAction() -> HostAPIConsentAction {
    HostAPIConsentAction(
      actionType: try! type.toHostAPIActionType(),
      pubData: String(describing: publisherData),
      campaignType: try! campaignType.toHostAPICampaignType(),
      customActionId: customActionId
    )
  }
}

extension SPCampaignType {
  func toHostAPICampaignType() throws -> HostAPICampaignType {
    switch self {
    case .ccpa:
      HostAPICampaignType.ccpa
    case .gdpr:
      HostAPICampaignType.gdpr
    default:
      // NOTE: there is no support for all other campaign types
      throw NotImplementedError.notImplemented
    }
  }
}

// FIXME(thekorn) the anddroid and the ios sdk are actually diverging here.
//   ios is using newer and more granular action types, whereas
//   android is still using the old ones
//   once android is catching up we need to unify
extension SPActionType {
  func toHostAPIActionType() throws -> HostAPIActionType {
    switch self {
    case .SaveAndExit:
      HostAPIActionType.saveAndExit
    case .PMCancel:
      HostAPIActionType.msgCancel
    case .Custom:
      HostAPIActionType.custom
    case .AcceptAll:
      HostAPIActionType.acceptAll
    case .ShowPrivacyManager:
      HostAPIActionType.showOptions
    case .RejectAll:
      HostAPIActionType.rejectAll
    case .Dismiss:
      HostAPIActionType.pmDismiss
    case .RequestATTAccess:
      throw NotImplementedError.notImplemented
    case .IDFAAccepted:
      throw NotImplementedError.notImplemented
    case .IDFADenied:
      throw NotImplementedError.notImplemented
    case .Unknown:
      HostAPIActionType.unknown
    }
  }
}

extension SPError {
  func toHostAPISPError() -> HostAPISPError {
    HostAPISPError(spCode: spCode, description: description)
  }
}
