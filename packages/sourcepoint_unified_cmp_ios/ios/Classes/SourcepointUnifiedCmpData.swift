import ConsentViewController

enum NotImplementedError: Error {
    case notImplemented
}

extension SPGDPRVendorGrant {
    func toHostAPIPurposeGrants() -> HostAPIGDPRPurposeGrants {
        return HostAPIGDPRPurposeGrants(granted: granted, purposeGrants: purposeGrants)
    }
}

extension ConsentStatus {
    func toHostAPIConsentStatus() -> HostAPIConsentStatus {
        return HostAPIConsentStatus(
            consentedAll: consentedAll,
            consentedToAny: consentedToAny,
            granularStatus: nil, /// granularStatus, /// FIXME: not public in the ios sdk
            hasConsentData: nil, /// hasConsentData,  /// FIXME: not public in the ios sdk
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
            let tcData: [String?: String?]? = value.consents!.tcfData?.dictionaryValue?.reduce(into: [:]) { result, pair in
                // Convert the value to String? if possible
                let value: String? = (pair.value as? String) ?? (pair.value as? CustomStringConvertible)?.description

                // Insert into the new dictionary
                result[pair.key] = value
            }

            let grants: [String?: HostAPIGDPRPurposeGrants?]? = value.consents?.vendorGrants.reduce(into: [:]) { result, pair in
                // Convert the value to String? if possible
                let value: SPGDPRVendorGrant = pair.value as SPGDPRVendorGrant

                // Insert into the new dictionary
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

extension SPUserData {
    func toHostAPISPConsent() -> HostAPISPConsent {
        return HostAPISPConsent(
            gdpr: try? gdpr?.toHostAPIGDPRConsent()
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
