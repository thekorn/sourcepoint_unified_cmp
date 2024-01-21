package de.thekorn.sourcepoint.unified.cmp


import HostAPICampaignType
import HostAPICampaignsEnv
import HostAPIMessageLanguage
import HostAPIMessageType
import HostAPIPMTab
import HostAPISPConsent
import HostAPISPError
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
import com.sourcepoint.cmplibrary.exception.CampaignType
import com.sourcepoint.cmplibrary.model.ConsentAction
import com.sourcepoint.cmplibrary.model.exposed.SPConsents
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
        val message: String = error.message ?: "unknown error"
        val cause: String = error.cause?.javaClass?.simpleName ?: message
        flutterApi!!.onError(HostAPISPError(cause, message)) {
            callback(
                    Result.success(Unit)
            )
        }
    }

    fun callOnAction(view: View, consentAction: ConsentAction, callback: (Result<Unit>) -> Unit) {
        activity.runOnUiThread {
            flutterApi!!.onAction(view.id.toLong(), consentAction.toHostAPIConsentAction()) {
                callback(
                        Result.success(Unit)
                )
            }
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
    override fun loadMessage(accountId: Long, propertyId: Long, propertyName: String, pmId: String, messageLanguage: HostAPIMessageLanguage, campaignsEnv: HostAPICampaignsEnv, messageTimeout: Long, runGDPRCampaign: Boolean, runCCPACampaign: Boolean, callback: (Result<HostAPISPConsent>) -> Unit) {
        Log.d("SourcepointUnifiedCmp", "loadMessage")
        val cmpConfig = SpConfigDataBuilder()
                .addAccountId(accountId.toInt())
                .addPropertyId(propertyId.toInt())
                .addPropertyName(propertyName)
                .addMessageLanguage(messageLanguage.toMessageLanguage())
                .addCampaignsEnv(campaignsEnv.toCampaignsEnv())
                .addMessageTimeout(messageTimeout)
        if (runGDPRCampaign) cmpConfig.addCampaign(CampaignType.GDPR)
        if (runCCPACampaign) cmpConfig.addCampaign(CampaignType.CCPA)

        Log.d("SourcepointUnifiedCmp", "loadMessage")
        val spClient = LocalClient()

        spConsentLib =
                makeConsentLib(spConfig = cmpConfig.build(), activity = this.activity, spClient = spClient)
        spConsentLib!!.loadMessage()
        spClient.isInitialized.invokeOnCompletion {
            callback(Result.success(spClient.isInitialized.getCompleted()))
        }
    }

    override fun loadPrivacyManager(
        pmId: String,
        pmTab: HostAPIPMTab,
        campaignType: HostAPICampaignType,
        messageType: HostAPIMessageType,
        callback: (Result<Unit>) -> Unit
    ) {
        spConsentLib?.loadPrivacyManager(
            pmId,
            pmTab.toPMTab(),
            campaignType.toCampaignType(),
            messageType.toMessageType()
        )
    }

}