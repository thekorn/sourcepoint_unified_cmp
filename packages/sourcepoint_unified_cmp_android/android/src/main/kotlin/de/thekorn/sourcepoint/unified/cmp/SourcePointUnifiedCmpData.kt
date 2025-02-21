package de.thekorn.sourcepoint.unified.cmp

import HostAPIActionType
import HostAPICampaignType
import HostAPICampaignsEnv
import HostAPIConsentAction
import HostAPIConsentStatus
import HostAPIGDPRConsent
import HostAPIGDPRPurposeGrants
import HostAPIGranularState
import HostAPIGranularStatus
import HostAPIMessageLanguage
import HostAPIMessageType
import HostAPIPMTab
import HostAPISPConsent
import com.sourcepoint.cmplibrary.data.network.model.optimized.ConsentStatus
import com.sourcepoint.cmplibrary.data.network.model.optimized.GranularState
import com.sourcepoint.cmplibrary.data.network.util.CampaignsEnv
import com.sourcepoint.cmplibrary.exception.CampaignType
import com.sourcepoint.cmplibrary.model.ConsentAction
import com.sourcepoint.cmplibrary.model.MessageLanguage
import com.sourcepoint.cmplibrary.model.PMTab
import com.sourcepoint.cmplibrary.model.exposed.ActionType
import com.sourcepoint.cmplibrary.model.exposed.GDPRPurposeGrants
import com.sourcepoint.cmplibrary.model.exposed.MessageType
import com.sourcepoint.cmplibrary.model.exposed.SPConsents
import com.sourcepoint.cmplibrary.model.exposed.SPGDPRConsent
import com.sourcepoint.cmplibrary.model.exposed.toWebViewConsentsJsonObject

fun GDPRPurposeGrants.toHostAPIPurposeGrants() = HostAPIGDPRPurposeGrants(
    granted = granted,
    purposeGrants = purposeGrants.mapKeys { it.key }.mapValues { it.value }
)

fun SPGDPRConsent.toHostAPIGDPRConsent() = HostAPIGDPRConsent(
    uuid = consent.uuid,
    tcData = consent.tcData.mapKeys { it.key }.mapValues { it.value?.toString() },
    grants = consent.grants.mapKeys { it.key }.mapValues { it.value.toHostAPIPurposeGrants() },
    apply = consent.applies,
    euconsent = consent.euconsent,
    consentStatus = consent.consentStatus?.toHostAPIConsentStatus(),
    acceptedCategories = consent.acceptedCategories
)

fun GranularState.toHostAPIGranularState() = when (this) {
    GranularState.ALL -> HostAPIGranularState.ALL
    GranularState.SOME -> HostAPIGranularState.SOME
    GranularState.NONE -> HostAPIGranularState.NONE
    GranularState.EMPTY_VL -> HostAPIGranularState.EMPTY_VL
}

fun ConsentStatus.GranularStatus.toHostAPIGranularStatus() = HostAPIGranularStatus(
    defaultConsent = defaultConsent,
    previousOptInAll = previousOptInAll,
    purposeConsent = purposeConsent?.toHostAPIGranularState(),
    purposeLegInt = purposeLegInt?.toHostAPIGranularState(),
    vendorConsent = vendorConsent?.toHostAPIGranularState(),
    vendorLegInt = vendorLegInt?.toHostAPIGranularState()
)

fun ConsentStatus.toHostAPIConsentStatus() = HostAPIConsentStatus(
    consentedAll = consentedAll,
    consentedToAny = consentedToAny,
    granularStatus = granularStatus?.toHostAPIGranularStatus(),
    hasConsentData = hasConsentData,
    rejectedAny = rejectedAny,
    rejectedLI = rejectedLI,
    legalBasisChanges = legalBasisChanges,
    vendorListAdditions = vendorListAdditions
)

fun SPConsents.toHostAPISPConsent() = HostAPISPConsent(
    gdpr = gdpr?.toHostAPIGDPRConsent(),
    webConsents = this.toWebViewConsentsJsonObject().toString()
)

fun ConsentAction.toHostAPIConsentAction() = HostAPIConsentAction(
    actionType = actionType.toHostAPIActionType(),
    campaignType = campaignType.toHostAPICampaignType(),
    pubData = pubData.toString(),
    customActionId = customActionId
)

fun CampaignType.toHostAPICampaignType() = when (this) {
    CampaignType.CCPA -> HostAPICampaignType.CCPA
    CampaignType.GDPR -> HostAPICampaignType.GDPR
    CampaignType.USNAT -> HostAPICampaignType.USNAT
}

fun ActionType.toHostAPIActionType() = when (this) {
    ActionType.ACCEPT_ALL -> HostAPIActionType.ACCEPT_ALL
    ActionType.CUSTOM -> HostAPIActionType.CUSTOM
    ActionType.GET_MSG_ERROR -> HostAPIActionType.GET_MSG_ERROR
    ActionType.GET_MSG_NOT_CALLED -> HostAPIActionType.GET_MESSAGE_NOT_CALLED
    ActionType.MSG_CANCEL -> HostAPIActionType.MSG_CANCEL
    ActionType.PM_DISMISS -> HostAPIActionType.PM_DISMISS
    ActionType.REJECT_ALL -> HostAPIActionType.REJECT_ALL
    ActionType.SAVE_AND_EXIT -> HostAPIActionType.SAVE_AND_EXIT
    ActionType.SHOW_OPTIONS -> HostAPIActionType.SHOW_OPTIONS
    ActionType.UNKNOWN -> HostAPIActionType.UNKNOWN
}

fun HostAPIMessageLanguage.toMessageLanguage() = when (this) {
    HostAPIMessageLanguage.ENGLISH -> MessageLanguage.ENGLISH
    HostAPIMessageLanguage.GERMAN -> MessageLanguage.GERMAN
    HostAPIMessageLanguage.SPANISH -> MessageLanguage.SPANISH
    HostAPIMessageLanguage.FRENCH -> MessageLanguage.FRENCH
    HostAPIMessageLanguage.ITALIAN -> MessageLanguage.ITALIAN
    HostAPIMessageLanguage.DUTCH -> MessageLanguage.DUTCH
}

fun HostAPICampaignsEnv.toCampaignsEnv() = when (this) {
    HostAPICampaignsEnv.PUBLIC -> CampaignsEnv.PUBLIC
    HostAPICampaignsEnv.STAGE -> CampaignsEnv.STAGE
}

fun HostAPIPMTab.toPMTab() = when (this) {
    HostAPIPMTab.PURPOSES -> PMTab.PURPOSES
    HostAPIPMTab.DEFAULTS -> PMTab.DEFAULT
    HostAPIPMTab.VENDORS -> PMTab.VENDORS
    HostAPIPMTab.FEATURES -> PMTab.FEATURES
}

fun HostAPICampaignType.toCampaignType() = when (this) {
    HostAPICampaignType.CCPA -> CampaignType.CCPA
    HostAPICampaignType.GDPR -> CampaignType.GDPR
    HostAPICampaignType.USNAT -> CampaignType.USNAT
}

fun HostAPIMessageType.toMessageType() = when (this) {
    HostAPIMessageType.MOBILE -> MessageType.MOBILE
    HostAPIMessageType.OTT -> MessageType.OTT
    HostAPIMessageType.LEGACY_OTT -> MessageType.LEGACY_OTT
}
