package de.thekorn.sourcepoint.unified.cmp


import HostAPIConsentStatus
import HostAPIGDPRConsent
import HostAPIGDPRPurposeGrants
import HostAPIGranularState
import HostAPIGranularStatus
import HostAPISPConsent
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


class SourcepointUnifiedCmpPlugin : FlutterPlugin, ActivityAware, SourcepointUnifiedCmpHostApi {
    private lateinit var binaryMessenger: BinaryMessenger
    private lateinit var activity: Activity

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
        }

        override fun onUIReady(view: View) {
            Log.d("SourcepointUnifiedCmp", "onUIReady")
            spConsentLib?.showView(view)
        }

        override fun onNativeMessageReady(
            message: MessageStructure,
            messageController: NativeMessageController
        ) {
            Log.d("SourcepointUnifiedCmp", "onNativeMessageReady")
        }

        override fun onError(error: Throwable) {
            Log.d("SourcepointUnifiedCmp", "onError")

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
        }

        override fun onConsentReady(consent: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onConsentReady $consent")
            isInitialized.complete(consent.toSpConsent())
        }

        override fun onAction(view: View, consentAction: ConsentAction): ConsentAction =
            consentAction

        override fun onNoIntentActivitiesFound(url: String) {
            Log.d("SourcepointUnifiedCmp", "onNoIntentActivitiesFound")
        }

        override fun onSpFinished(sPConsents: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onSpFinished")
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
    purposeGrants = purposeGrants.mapKeys { it.key}.mapValues { it.value},
)


fun SPGDPRConsent.toHostAPIGDPRConsent() = HostAPIGDPRConsent(
    uuid = consent.uuid,
    tcData = consent.tcData.mapKeys { it.key}.mapValues { it.value?.toString()},
    grants = consent.grants.mapKeys { it.key}.mapValues { it.value.toHostAPIPurposeGrants() },
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


fun SPConsents.toSpConsent() = HostAPISPConsent(
    gdpr = gdpr?.toHostAPIGDPRConsent()
)