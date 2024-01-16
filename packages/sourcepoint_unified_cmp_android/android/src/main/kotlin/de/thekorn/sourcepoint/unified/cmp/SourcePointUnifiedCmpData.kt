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
import HostAPISPConsent
import com.sourcepoint.cmplibrary.data.network.model.optimized.ConsentStatus
import com.sourcepoint.cmplibrary.data.network.model.optimized.GranularState
import com.sourcepoint.cmplibrary.data.network.util.CampaignsEnv
import com.sourcepoint.cmplibrary.exception.CampaignType
import com.sourcepoint.cmplibrary.model.ConsentAction
import com.sourcepoint.cmplibrary.model.MessageLanguage
import com.sourcepoint.cmplibrary.model.exposed.ActionType
import com.sourcepoint.cmplibrary.model.exposed.GDPRPurposeGrants
import com.sourcepoint.cmplibrary.model.exposed.SPConsents
import com.sourcepoint.cmplibrary.model.exposed.SPGDPRConsent
import io.flutter.Log


fun GDPRPurposeGrants.toHostAPIPurposeGrants() = HostAPIGDPRPurposeGrants(
    granted = granted,
    purposeGrants = purposeGrants.mapKeys { it.key }.mapValues { it.value },
)


fun SPGDPRConsent.toHostAPIGDPRConsent() = HostAPIGDPRConsent(
    uuid = consent.uuid,
    tcData = consent.tcData.mapKeys { it.key }.mapValues { it.value?.toString() },
    grants = consent.grants.mapKeys { it.key }.mapValues { it.value.toHostAPIPurposeGrants() },
    apply = consent.applies,
    euconsent = consent.euconsent,
    consentStatus = consent.consentStatus?.toHostAPIConsentStatus(),
    acceptedCategories = consent.acceptedCategories,
)

fun GranularState.toHostAPIGranularState() = when (this) {
    GranularState.ALL -> HostAPIGranularState.ALL
    GranularState.SOME -> HostAPIGranularState.SOME
    GranularState.NONE -> HostAPIGranularState.NONE
}

fun ConsentStatus.GranularStatus.toHostAPIGranularStatus() = HostAPIGranularStatus(
    defaultConsent = defaultConsent,
    previousOptInAll = previousOptInAll,
    purposeConsent = purposeConsent?.toHostAPIGranularState(),
    purposeLegInt = purposeLegInt?.toHostAPIGranularState(),
    vendorConsent = vendorConsent?.toHostAPIGranularState(),
    vendorLegInt = vendorLegInt?.toHostAPIGranularState(),
)


fun ConsentStatus.toHostAPIConsentStatus() = HostAPIConsentStatus(
    consentedAll = consentedAll,
    consentedToAny = consentedToAny,
    granularStatus = granularStatus?.toHostAPIGranularStatus(),
    hasConsentData = hasConsentData,
    rejectedAny = rejectedAny,
    rejectedLI = rejectedLI,
    legalBasisChanges = legalBasisChanges,
    vendorListAdditions = vendorListAdditions,
)


fun SPConsents.toHostAPISPConsent() = HostAPISPConsent(
    gdpr = gdpr?.toHostAPIGDPRConsent()
)

fun ConsentAction.toHostAPIConsentAction() = HostAPIConsentAction(
    actionType = actionType.toHostAPIActionType(),
    campaignType = campaignType.toHostAPICampaignType(),
    pubData = pubData.toString(),
    customActionId = customActionId,
)

fun CampaignType.toHostAPICampaignType() = when (this) {
    CampaignType.CCPA -> HostAPICampaignType.CCPA
    CampaignType.GDPR -> HostAPICampaignType.GDPR
}

fun ActionType.toHostAPIActionType() = when (this) {
    ActionType.ACCEPT_ALL -> HostAPIActionType.ACCEPTALL
    ActionType.CUSTOM -> HostAPIActionType.CUSTOM
    ActionType.GET_MSG_ERROR -> HostAPIActionType.GETMSGERROR
    ActionType.GET_MSG_NOT_CALLED -> HostAPIActionType.GETMESSAGENOTCALLED
    ActionType.MSG_CANCEL -> HostAPIActionType.MSGCANCEL
    ActionType.PM_DISMISS -> HostAPIActionType.PMDISMISS
    ActionType.REJECT_ALL -> HostAPIActionType.REJECTALL
    ActionType.SAVE_AND_EXIT -> HostAPIActionType.SAVEANDEXIT
    ActionType.SHOW_OPTIONS -> HostAPIActionType.SHOWOPTIONS
    ActionType.UNKNOWN -> HostAPIActionType.UNKNOWN
}

fun HostAPIMessageLanguage.toMessageLanguage() = when (this) {
    HostAPIMessageLanguage.ENGLISH -> MessageLanguage.ENGLISH
    HostAPIMessageLanguage.GERMAN -> MessageLanguage.GERMAN
    HostAPIMessageLanguage.SPANISH -> MessageLanguage.SPANISH
    HostAPIMessageLanguage.FRENCH -> MessageLanguage.FRENCH
    HostAPIMessageLanguage.ITALIAN -> MessageLanguage.ITALIAN
}

fun HostAPICampaignsEnv.toCampaignsEnv() = when (this) {
    HostAPICampaignsEnv.PUBLIC -> CampaignsEnv.PUBLIC
    HostAPICampaignsEnv.STAGE -> CampaignsEnv.STAGE
}