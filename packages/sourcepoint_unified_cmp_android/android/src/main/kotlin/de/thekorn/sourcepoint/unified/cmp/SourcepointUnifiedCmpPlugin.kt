package de.thekorn.sourcepoint.unified.cmp


import SPConfig
import SourcepointUnifiedCmpApi
import android.app.Activity
import android.view.View
import com.sourcepoint.cmplibrary.NativeMessageController
import com.sourcepoint.cmplibrary.SpClient
import com.sourcepoint.cmplibrary.SpConsentLib
import com.sourcepoint.cmplibrary.core.nativemessage.MessageStructure
import com.sourcepoint.cmplibrary.creation.SpConfigDataBuilder
import com.sourcepoint.cmplibrary.creation.makeConsentLib
import com.sourcepoint.cmplibrary.data.network.util.CampaignsEnv
import com.sourcepoint.cmplibrary.exception.CampaignType
import com.sourcepoint.cmplibrary.model.ConsentAction
import com.sourcepoint.cmplibrary.model.MessageLanguage
import com.sourcepoint.cmplibrary.model.exposed.SPConsents
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import org.json.JSONObject


class SourcepointUnifiedCmpPlugin : FlutterPlugin, ActivityAware, SourcepointUnifiedCmpApi {
    private lateinit var binaryMessenger: BinaryMessenger;
    private lateinit var activity: Activity;

    private var spConsentLib: SpConsentLib? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "attach")
        this.binaryMessenger = flutterPluginBinding.binaryMessenger;

        SourcepointUnifiedCmpApi.setUp(this.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("SourcepointUnifiedCmp", "dettach")
        SourcepointUnifiedCmpApi.setUp(this.binaryMessenger, null)
    }

    override fun loadPrivacyManager(
        accountId: Long,
        propertyId: Long,
        propertyName: String,
        pmId: String,
        callback: (kotlin.Result<Unit>) -> Unit
    ) {
        Log.d("SourcepointUnifiedCmp", "loadPrivacyManager $accountId")
        //TODO("Not yet implemented")
    }

    override fun showPrivacyManager(config: SPConfig, callback: (kotlin.Result<Unit>) -> Unit) {
        Log.d("SourcepointUnifiedCmp", "showPrivacyManager")
        //TODO("Not yet implemented")
    }

    override fun setPlatformCmpConfig(config: SPConfig, callback: (kotlin.Result<Unit>) -> Unit) {
        Log.d("SourcepointUnifiedCmp", "setPlatformCmpConfig")
        //TODO("Not yet implemented")
    }

    override fun init(
        accountId: Long,
        propertyId: Long,
        propertyName: String,
        pmId: String,
        callback: (Result<Unit>) -> Unit
    ) {
        Log.d("SourcepointUnifiedCmp", "INIT")
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
        Log.d("SourcepointUnifiedCmp", "INIT DONE")
        spConsentLib =  makeConsentLib(spConfig = cmpConfig, activity = this.activity, spClient = LocalClient())
        spConsentLib!!.loadMessage()
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
        override fun onUIFinished(view: View) {
            Log.d("SourcepointUnifiedCmp", "onUIFinished")
            spConsentLib?.removeView(view)
        }
        override fun onUIReady(view: View) {
            Log.d("SourcepointUnifiedCmp", "onUIReady")
            spConsentLib?.showView(view)
        }
        override fun onNativeMessageReady(message: MessageStructure, messageController: NativeMessageController) {
            Log.d("SourcepointUnifiedCmp", "onNativeMessageReady")
        }
        override fun onError(error: Throwable) {
            Log.d("SourcepointUnifiedCmp", "onError")}
        @Deprecated("onMessageReady callback will be removed in favor of onUIReady. Currently this callback is disabled.")
        override fun onMessageReady(message: JSONObject) {
            Log.d("SourcepointUnifiedCmp", "onMessageReady")}

        override fun onConsentReady(consent: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onConsentReady $consent")}
        override fun onAction(view: View, consentAction: ConsentAction): ConsentAction = consentAction
        override fun onNoIntentActivitiesFound(url: String) {
            Log.d("SourcepointUnifiedCmp", "onNoIntentActivitiesFound")}
        override fun onSpFinished(sPConsents: SPConsents) {
            Log.d("SourcepointUnifiedCmp", "onSpFinished") }
    }

}