package de.thekorn.sourcepoint.unified.cmp


import HostAPIActionType
import HostAPICampaignType
import HostAPIConsentAction
import HostAPIConsentStatus
import HostAPIGDPRConsent
import HostAPIGDPRPurposeGrants
import HostAPIGranularState
import HostAPIGranularStatus
import HostAPISPConsent
import SourcepointUnifiedCmpFlutterApi
import SourcepointUnifiedCmpHostApi
import android.app.Activity
import android.view.View
import com.sourcepoint.cmplibrary.NativeMessageController
import com.sourcepoint.cmplibrary.SpClient
import com.sourcepoint.cmplibrary.SpConsentLib
import com.sourcepoint.cmplibrary.core.nativemessage.MessageStructure
import com.sourcepoint.cmplibrary.creation.SpConfigDataBuilder
import com.sourcepoint.cmplibrary.creation.makeConsentLib
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
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.json.JSONObject

private class SourcepointFlutterApi(
    binaryMessenger: BinaryMessenger,
    private val activity: Activity
) {

    var flutterApi: SourcepointUnifiedCmpFlutterApi? = null

    init {
        flutterApi = SourcepointUnifiedCmpFlutterApi(binaryMessenger)
    }

    fun callOnConsentReady(consent: SPConsents, callback: (Result<Unit>) -> Unit) {
        flutterApi!!.onConsentReady(consent.toHostAPISPConsent()) { callback(Result.success(Unit)) }
    }

    fun callOnUIFinished(view: View, callback: (Result<Unit>) -> Unit) {
        flutterApi!!.onUIFinished(view.id.toLong()) { callback(Result.success(Unit)) }
    }

    fun callOnUIReady(view: View, callback: (Result<Unit>) -> Unit) {
        flutterApi!!.onUIReady(view.id.toLong()) { callback(Result.success(Unit)) }
    }

    fun callOnError(error: Throwable, callback: (Result<Unit>) -> Unit) {
        //FIXME: need to map the throwable to the error type
        flutterApi!!.onError(HostAPISourcepointUnifiedCmpError.INVALIDARGUMENTEXCEPTION) {
            callback(
                Result.success(Unit)
            )
        }
    }

    fun callOnAction(view: View, consentAction: ConsentAction, callback: (Result<Unit>) -> Unit) {
        flutterApi!!.onAction(view.id.toLong(), consentAction.toHostAPIConsentAction()) {
            callback(
                Result.success(Unit)
            )
        }
    }

    fun callOnNoIntentActivitiesFound(url: String, callback: (Result<Unit>) -> Unit) {
        flutterApi!!.onNoIntentActivitiesFound(url) { callback(Result.success(Unit)) }
    }

    fun callOnSpFinished(consent: SPConsents, callback: (Result<Unit>) -> Unit) {
        activity.runOnUiThread {
            flutterApi!!.onSpFinished(consent.toHostAPISPConsent()) { callback(Result.success(Unit)) }
        }
    }
}

class SourcepointUnifiedCmpPlugin : FlutterPlugin, ActivityAware, SourcepointUnifiedCmpHostApi {
    private lateinit var binaryMessenger: BinaryMessenger
    private lateinit var activity: Activity
    private lateinit var flutterApi: SourcepointFlutterApi

    private var spConsentLib: SpConsentLib? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "attach")
        this.binaryMessenger = flutterPluginBinding.binaryMessenger

        SourcepointUnifiedCmpHostApi.setUp(this.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "detached")
        SourcepointUnifiedCmpHostApi.setUp(this.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "onAttachedToActivity")
        activity = binding.activity
        this.flutterApi = SourcepointFlutterApi(binaryMessenger, this.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d("SourcepointUnifiedCmp", "onDetachedFromActivityForConfigChanges")
        //TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "onReattachedToActivityForConfigChanges")
        ///TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        Log.d("SourcepointUnifiedCmp", "onDetachedFromActivity")
        //TODO("Not yet implemented")
    }


    internal inner class LocalClient : SpClient {
        val isInitialized: CompletableDeferred<HostAPISPConsent> = CompletableDeferred()
        override fun onUIFinished(view: View) {
            Log.d("SourcepointUnifiedCmp", "onUIFinished")
            spConsentLib?.removeView(view)
            flutterApi.callOnUIFinished(view) {}
        }

        override fun onUIReady(view: View) {
            Log.d("SourcepointUnifiedCmp", "onUIReady")
            spConsentLib?.showView(view)
            flutterApi.callOnUIReady(view) {}
        }

        override fun onNativeMessageReady(
            message: MessageStructure,
            messageController: NativeMessageController
        ) {
            Log.d("SourcepointUnifiedCmp", "onNativeMessageReady")
        }

        override fun onError(error: Throwable) {
            Log.d("SourcepointUnifiedCmp", "onError")
            flutterApi.callOnError(error) {}
        }

        @Deprecated(
            "onMessageReady callback will be removed in favor of onUIReady. Currently this callback is disabled.",
            ReplaceWith(
                "onUIReady",
                "com.sourcepoint.cmplibrary.SpClient"
            )
        )
        override fun onMessageReady(message: JSONObject) {
            Log.d("SourcepointUnifiedCmp", "onMessageReady")
            // FIXME: that's missing
        }

        override fun onConsentReady(consent: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onConsentReady $consent")
            isInitialized.complete(consent.toHostAPISPConsent())
            flutterApi.callOnConsentReady(consent) {}
        }

        override fun onAction(view: View, consentAction: ConsentAction): ConsentAction {
            Log.d("SourcepointUnifiedCmp", "onAction $consentAction")
            flutterApi.callOnAction(view, consentAction) {}
            return consentAction
        }

        override fun onNoIntentActivitiesFound(url: String) {
            Log.d("SourcepointUnifiedCmp", "onNoIntentActivitiesFound")
            flutterApi.callOnNoIntentActivitiesFound(url) {}
        }

        override fun onSpFinished(sPConsents: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onSpFinished")
            flutterApi.callOnSpFinished(sPConsents) {}
        }
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun loadMessage(
        accountId: Long,
        propertyId: Long,
        propertyName: String,
        pmId: String,
        callback: (Result<HostAPISPConsent>) -> Unit
    ) {
        Log.d("SourcepointUnifiedCmp", "loadMessage")
        val cmpConfig = SpConfigDataBuilder()
            .addAccountId(accountId.toInt())
            .addPropertyId(propertyId.toInt())
            .addPropertyName(propertyName)
            .addMessageLanguage(MessageLanguage.ENGLISH) // Optional, default ENGLISH
            .addCampaignsEnv(CampaignsEnv.PUBLIC) // Optional, default PUBLIC
            .addMessageTimeout(4000) // Optional, default 3000ms
            .addCampaign(CampaignType.GDPR)
            .addCampaign(CampaignType.CCPA)
            .build()
        Log.d("SourcepointUnifiedCmp", "loadMessage")
        val spClient = LocalClient()

        spConsentLib =
            makeConsentLib(spConfig = cmpConfig, activity = this.activity, spClient = spClient)
        spConsentLib!!.loadMessage()
        spClient.isInitialized.invokeOnCompletion {
            callback(Result.success(spClient.isInitialized.getCompleted()))
        }
    }

}

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
    pubData = pubData,
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
