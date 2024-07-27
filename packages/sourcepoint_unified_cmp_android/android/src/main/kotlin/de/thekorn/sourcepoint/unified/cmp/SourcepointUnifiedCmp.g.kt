// Autogenerated from Pigeon (v21.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is HostApiFlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): HostApiFlutterError {
  return HostApiFlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class HostApiFlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class HostAPIPMTab(val raw: Int) {
  DEFAULTS(0),
  PURPOSES(1),
  VENDORS(2),
  FEATURES(3);

  companion object {
    fun ofRaw(raw: Int): HostAPIPMTab? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPICampaignType(val raw: Int) {
  GDPR(0),
  CCPA(1),
  USNAT(2);

  companion object {
    fun ofRaw(raw: Int): HostAPICampaignType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPIMessageType(val raw: Int) {
  MOBILE(0),
  OTT(1),
  LEGACY_OTT(2);

  companion object {
    fun ofRaw(raw: Int): HostAPIMessageType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPIGranularState(val raw: Int) {
  ALL(0),
  SOME(1),
  NONE(2),
  EMPTY_VL(3);

  companion object {
    fun ofRaw(raw: Int): HostAPIGranularState? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPIActionType(val raw: Int) {
  SHOW_OPTIONS(0),
  REJECT_ALL(1),
  ACCEPT_ALL(2),
  MSG_CANCEL(3),
  CUSTOM(4),
  SAVE_AND_EXIT(5),
  PM_DISMISS(6),
  GET_MSG_ERROR(7),
  GET_MESSAGE_NOT_CALLED(8),
  UNKNOWN(9);

  companion object {
    fun ofRaw(raw: Int): HostAPIActionType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPIMessageLanguage(val raw: Int) {
  ENGLISH(0),
  FRENCH(1),
  GERMAN(2),
  ITALIAN(3),
  SPANISH(4);

  companion object {
    fun ofRaw(raw: Int): HostAPIMessageLanguage? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class HostAPICampaignsEnv(val raw: Int) {
  STAGE(0),
  PUBLIC(1);

  companion object {
    fun ofRaw(raw: Int): HostAPICampaignsEnv? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPIConsentAction (
  val actionType: HostAPIActionType,
  val pubData: String,
  val campaignType: HostAPICampaignType,
  val customActionId: String? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPIConsentAction {
      val actionType = __pigeon_list[0] as HostAPIActionType
      val pubData = __pigeon_list[1] as String
      val campaignType = __pigeon_list[2] as HostAPICampaignType
      val customActionId = __pigeon_list[3] as String?
      return HostAPIConsentAction(actionType, pubData, campaignType, customActionId)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      actionType,
      pubData,
      campaignType,
      customActionId,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPIGDPRPurposeGrants (
  val granted: Boolean,
  val purposeGrants: Map<String?, Boolean?>? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPIGDPRPurposeGrants {
      val granted = __pigeon_list[0] as Boolean
      val purposeGrants = __pigeon_list[1] as Map<String?, Boolean?>?
      return HostAPIGDPRPurposeGrants(granted, purposeGrants)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      granted,
      purposeGrants,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPISPError (
  val cause: String,
  val message: String

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPISPError {
      val cause = __pigeon_list[0] as String
      val message = __pigeon_list[1] as String
      return HostAPISPError(cause, message)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      cause,
      message,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPIGranularStatus (
  val defaultConsent: Boolean? = null,
  val previousOptInAll: Boolean? = null,
  val purposeConsent: HostAPIGranularState? = null,
  val purposeLegInt: HostAPIGranularState? = null,
  val vendorConsent: HostAPIGranularState? = null,
  val vendorLegInt: HostAPIGranularState? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPIGranularStatus {
      val defaultConsent = __pigeon_list[0] as Boolean?
      val previousOptInAll = __pigeon_list[1] as Boolean?
      val purposeConsent = __pigeon_list[2] as HostAPIGranularState?
      val purposeLegInt = __pigeon_list[3] as HostAPIGranularState?
      val vendorConsent = __pigeon_list[4] as HostAPIGranularState?
      val vendorLegInt = __pigeon_list[5] as HostAPIGranularState?
      return HostAPIGranularStatus(defaultConsent, previousOptInAll, purposeConsent, purposeLegInt, vendorConsent, vendorLegInt)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      defaultConsent,
      previousOptInAll,
      purposeConsent,
      purposeLegInt,
      vendorConsent,
      vendorLegInt,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPIConsentStatus (
  val consentedAll: Boolean? = null,
  val consentedToAny: Boolean? = null,
  val granularStatus: HostAPIGranularStatus? = null,
  val hasConsentData: Boolean? = null,
  val rejectedAny: Boolean? = null,
  val rejectedLI: Boolean? = null,
  val legalBasisChanges: Boolean? = null,
  val vendorListAdditions: Boolean? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPIConsentStatus {
      val consentedAll = __pigeon_list[0] as Boolean?
      val consentedToAny = __pigeon_list[1] as Boolean?
      val granularStatus = __pigeon_list[2] as HostAPIGranularStatus?
      val hasConsentData = __pigeon_list[3] as Boolean?
      val rejectedAny = __pigeon_list[4] as Boolean?
      val rejectedLI = __pigeon_list[5] as Boolean?
      val legalBasisChanges = __pigeon_list[6] as Boolean?
      val vendorListAdditions = __pigeon_list[7] as Boolean?
      return HostAPIConsentStatus(consentedAll, consentedToAny, granularStatus, hasConsentData, rejectedAny, rejectedLI, legalBasisChanges, vendorListAdditions)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      consentedAll,
      consentedToAny,
      granularStatus,
      hasConsentData,
      rejectedAny,
      rejectedLI,
      legalBasisChanges,
      vendorListAdditions,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPIGDPRConsent (
  val uuid: String? = null,
  val tcData: Map<String?, String?>? = null,
  val grants: Map<String?, HostAPIGDPRPurposeGrants?>? = null,
  val euconsent: String,
  val acceptedCategories: List<String?>? = null,
  val apply: Boolean,
  val consentStatus: HostAPIConsentStatus? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPIGDPRConsent {
      val uuid = __pigeon_list[0] as String?
      val tcData = __pigeon_list[1] as Map<String?, String?>?
      val grants = __pigeon_list[2] as Map<String?, HostAPIGDPRPurposeGrants?>?
      val euconsent = __pigeon_list[3] as String
      val acceptedCategories = __pigeon_list[4] as List<String?>?
      val apply = __pigeon_list[5] as Boolean
      val consentStatus = __pigeon_list[6] as HostAPIConsentStatus?
      return HostAPIGDPRConsent(uuid, tcData, grants, euconsent, acceptedCategories, apply, consentStatus)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      uuid,
      tcData,
      grants,
      euconsent,
      acceptedCategories,
      apply,
      consentStatus,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPICCPAConsent (
  val uuid: String? = null,
  val rejectedCategories: List<String?>? = null,
  val rejectedVendors: List<String?>? = null,
  val status: String? = null,
  val uspstring: String,
  val apply: Boolean

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPICCPAConsent {
      val uuid = __pigeon_list[0] as String?
      val rejectedCategories = __pigeon_list[1] as List<String?>?
      val rejectedVendors = __pigeon_list[2] as List<String?>?
      val status = __pigeon_list[3] as String?
      val uspstring = __pigeon_list[4] as String
      val apply = __pigeon_list[5] as Boolean
      return HostAPICCPAConsent(uuid, rejectedCategories, rejectedVendors, status, uspstring, apply)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      uuid,
      rejectedCategories,
      rejectedVendors,
      status,
      uspstring,
      apply,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class HostAPISPConsent (
  val gdpr: HostAPIGDPRConsent? = null,
  val ccpa: HostAPICCPAConsent? = null,
  val webConsents: String? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): HostAPISPConsent {
      val gdpr = __pigeon_list[0] as HostAPIGDPRConsent?
      val ccpa = __pigeon_list[1] as HostAPICCPAConsent?
      val webConsents = __pigeon_list[2] as String?
      return HostAPISPConsent(gdpr, ccpa, webConsents)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      gdpr,
      ccpa,
      webConsents,
    )
  }
}
private object SourcepointUnifiedCmpPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPIConsentAction.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPIGDPRPurposeGrants.fromList(it)
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPISPError.fromList(it)
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPIGranularStatus.fromList(it)
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPIConsentStatus.fromList(it)
        }
      }
      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPIGDPRConsent.fromList(it)
        }
      }
      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPICCPAConsent.fromList(it)
        }
      }
      136.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          HostAPISPConsent.fromList(it)
        }
      }
      137.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPIPMTab.ofRaw(it)
        }
      }
      138.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPICampaignType.ofRaw(it)
        }
      }
      139.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPIMessageType.ofRaw(it)
        }
      }
      140.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPIGranularState.ofRaw(it)
        }
      }
      141.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPIActionType.ofRaw(it)
        }
      }
      142.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPIMessageLanguage.ofRaw(it)
        }
      }
      143.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          HostAPICampaignsEnv.ofRaw(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is HostAPIConsentAction -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is HostAPIGDPRPurposeGrants -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      is HostAPISPError -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }
      is HostAPIGranularStatus -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      is HostAPIConsentStatus -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }
      is HostAPIGDPRConsent -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }
      is HostAPICCPAConsent -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }
      is HostAPISPConsent -> {
        stream.write(136)
        writeValue(stream, value.toList())
      }
      is HostAPIPMTab -> {
        stream.write(137)
        writeValue(stream, value.raw)
      }
      is HostAPICampaignType -> {
        stream.write(138)
        writeValue(stream, value.raw)
      }
      is HostAPIMessageType -> {
        stream.write(139)
        writeValue(stream, value.raw)
      }
      is HostAPIGranularState -> {
        stream.write(140)
        writeValue(stream, value.raw)
      }
      is HostAPIActionType -> {
        stream.write(141)
        writeValue(stream, value.raw)
      }
      is HostAPIMessageLanguage -> {
        stream.write(142)
        writeValue(stream, value.raw)
      }
      is HostAPICampaignsEnv -> {
        stream.write(143)
        writeValue(stream, value.raw)
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface SourcepointUnifiedCmpHostApi {
  fun loadMessage(accountId: Long, propertyId: Long, propertyName: String, pmId: String, messageLanguage: HostAPIMessageLanguage, campaignsEnv: HostAPICampaignsEnv, messageTimeout: Long, runGDPRCampaign: Boolean, runCCPACampaign: Boolean, runUSNATCampaign: Boolean, callback: (Result<HostAPISPConsent>) -> Unit)
  fun loadPrivacyManager(pmId: String, pmTab: HostAPIPMTab, campaignType: HostAPICampaignType, messageType: HostAPIMessageType, callback: (Result<Unit>) -> Unit)

  companion object {
    /** The codec used by SourcepointUnifiedCmpHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      SourcepointUnifiedCmpPigeonCodec
    }
    /** Sets up an instance of `SourcepointUnifiedCmpHostApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: SourcepointUnifiedCmpHostApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpHostApi.loadMessage$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val accountIdArg = args[0].let { num -> if (num is Int) num.toLong() else num as Long }
            val propertyIdArg = args[1].let { num -> if (num is Int) num.toLong() else num as Long }
            val propertyNameArg = args[2] as String
            val pmIdArg = args[3] as String
            val messageLanguageArg = args[4] as HostAPIMessageLanguage
            val campaignsEnvArg = args[5] as HostAPICampaignsEnv
            val messageTimeoutArg = args[6].let { num -> if (num is Int) num.toLong() else num as Long }
            val runGDPRCampaignArg = args[7] as Boolean
            val runCCPACampaignArg = args[8] as Boolean
            val runUSNATCampaignArg = args[9] as Boolean
            api.loadMessage(accountIdArg, propertyIdArg, propertyNameArg, pmIdArg, messageLanguageArg, campaignsEnvArg, messageTimeoutArg, runGDPRCampaignArg, runCCPACampaignArg, runUSNATCampaignArg) { result: Result<HostAPISPConsent> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpHostApi.loadPrivacyManager$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pmIdArg = args[0] as String
            val pmTabArg = args[1] as HostAPIPMTab
            val campaignTypeArg = args[2] as HostAPICampaignType
            val messageTypeArg = args[3] as HostAPIMessageType
            api.loadPrivacyManager(pmIdArg, pmTabArg, campaignTypeArg, messageTypeArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
class SourcepointUnifiedCmpFlutterApi(private val binaryMessenger: BinaryMessenger, private val messageChannelSuffix: String = "") {
  companion object {
    /** The codec used by SourcepointUnifiedCmpFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      SourcepointUnifiedCmpPigeonCodec
    }
  }
  fun onUIFinished(viewIdArg: Long, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onUIFinished$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onUIReady(viewIdArg: Long, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onUIReady$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onError(errorArg: HostAPISPError, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onError$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(errorArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onConsentReady(consentArg: HostAPISPConsent, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onConsentReady$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(consentArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onAction(viewIdArg: Long, consentActionArg: HostAPIConsentAction, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onAction$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg, consentActionArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onNoIntentActivitiesFound(urlArg: String, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(urlArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onSpFinished(consentArg: HostAPISPConsent, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onSpFinished$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(consentArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(HostApiFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
