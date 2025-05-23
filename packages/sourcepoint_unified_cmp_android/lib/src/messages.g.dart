// Autogenerated from Pigeon (v25.3.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse(
    {Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

bool _deepEquals(Object? a, Object? b) {
  if (a is List && b is List) {
    return a.length == b.length &&
        a.indexed
            .every(((int, dynamic) item) => _deepEquals(item.$2, b[item.$1]));
  }
  if (a is Map && b is Map) {
    return a.length == b.length &&
        a.entries.every((MapEntry<Object?, Object?> entry) =>
            (b as Map<Object?, Object?>).containsKey(entry.key) &&
            _deepEquals(entry.value, b[entry.key]));
  }
  return a == b;
}

enum HostAPIPMTab {
  defaults,
  purposes,
  vendors,
  features,
}

enum HostAPICampaignType {
  gdpr,
  ccpa,
  usnat,
}

enum HostAPIMessageType {
  mobile,
  ott,
  legacyOtt,
}

enum HostAPIGranularState {
  all,
  some,
  none,
  emptyVl,
}

enum HostAPIActionType {
  showOptions,
  rejectAll,
  acceptAll,
  msgCancel,
  custom,
  saveAndExit,
  pmDismiss,
  getMsgError,
  getMessageNotCalled,
  unknown,
}

enum HostAPIMessageLanguage {
  english,
  french,
  german,
  italian,
  spanish,
  dutch,
}

enum HostAPICampaignsEnv {
  stage,
  public,
}

class HostAPIConsentAction {
  HostAPIConsentAction({
    required this.actionType,
    required this.pubData,
    required this.campaignType,
    this.customActionId,
  });

  HostAPIActionType actionType;

  String pubData;

  HostAPICampaignType campaignType;

  String? customActionId;

  List<Object?> _toList() {
    return <Object?>[
      actionType,
      pubData,
      campaignType,
      customActionId,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPIConsentAction decode(Object result) {
    result as List<Object?>;
    return HostAPIConsentAction(
      actionType: result[0]! as HostAPIActionType,
      pubData: result[1]! as String,
      campaignType: result[2]! as HostAPICampaignType,
      customActionId: result[3] as String?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPIConsentAction || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPIGDPRPurposeGrants {
  HostAPIGDPRPurposeGrants({
    required this.granted,
    this.purposeGrants,
  });

  bool granted;

  Map<String?, bool?>? purposeGrants;

  List<Object?> _toList() {
    return <Object?>[
      granted,
      purposeGrants,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPIGDPRPurposeGrants decode(Object result) {
    result as List<Object?>;
    return HostAPIGDPRPurposeGrants(
      granted: result[0]! as bool,
      purposeGrants:
          (result[1] as Map<Object?, Object?>?)?.cast<String?, bool?>(),
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPIGDPRPurposeGrants ||
        other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPISPError {
  HostAPISPError({
    required this.cause,
    required this.message,
  });

  String cause;

  String message;

  List<Object?> _toList() {
    return <Object?>[
      cause,
      message,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPISPError decode(Object result) {
    result as List<Object?>;
    return HostAPISPError(
      cause: result[0]! as String,
      message: result[1]! as String,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPISPError || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPIGranularStatus {
  HostAPIGranularStatus({
    this.defaultConsent,
    this.previousOptInAll,
    this.purposeConsent,
    this.purposeLegInt,
    this.vendorConsent,
    this.vendorLegInt,
  });

  bool? defaultConsent;

  bool? previousOptInAll;

  HostAPIGranularState? purposeConsent;

  HostAPIGranularState? purposeLegInt;

  HostAPIGranularState? vendorConsent;

  HostAPIGranularState? vendorLegInt;

  List<Object?> _toList() {
    return <Object?>[
      defaultConsent,
      previousOptInAll,
      purposeConsent,
      purposeLegInt,
      vendorConsent,
      vendorLegInt,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPIGranularStatus decode(Object result) {
    result as List<Object?>;
    return HostAPIGranularStatus(
      defaultConsent: result[0] as bool?,
      previousOptInAll: result[1] as bool?,
      purposeConsent: result[2] as HostAPIGranularState?,
      purposeLegInt: result[3] as HostAPIGranularState?,
      vendorConsent: result[4] as HostAPIGranularState?,
      vendorLegInt: result[5] as HostAPIGranularState?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPIGranularStatus || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPIConsentStatus {
  HostAPIConsentStatus({
    this.consentedAll,
    this.consentedToAny,
    this.granularStatus,
    this.hasConsentData,
    this.rejectedAny,
    this.rejectedLI,
    this.legalBasisChanges,
    this.vendorListAdditions,
  });

  bool? consentedAll;

  bool? consentedToAny;

  HostAPIGranularStatus? granularStatus;

  bool? hasConsentData;

  bool? rejectedAny;

  bool? rejectedLI;

  bool? legalBasisChanges;

  bool? vendorListAdditions;

  List<Object?> _toList() {
    return <Object?>[
      consentedAll,
      consentedToAny,
      granularStatus,
      hasConsentData,
      rejectedAny,
      rejectedLI,
      legalBasisChanges,
      vendorListAdditions,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPIConsentStatus decode(Object result) {
    result as List<Object?>;
    return HostAPIConsentStatus(
      consentedAll: result[0] as bool?,
      consentedToAny: result[1] as bool?,
      granularStatus: result[2] as HostAPIGranularStatus?,
      hasConsentData: result[3] as bool?,
      rejectedAny: result[4] as bool?,
      rejectedLI: result[5] as bool?,
      legalBasisChanges: result[6] as bool?,
      vendorListAdditions: result[7] as bool?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPIConsentStatus || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPIGDPRConsent {
  HostAPIGDPRConsent({
    this.uuid,
    this.tcData,
    this.grants,
    required this.euconsent,
    this.acceptedCategories,
    required this.apply,
    this.consentStatus,
  });

  String? uuid;

  Map<String?, String?>? tcData;

  Map<String?, HostAPIGDPRPurposeGrants?>? grants;

  String euconsent;

  List<String?>? acceptedCategories;

  bool apply;

  HostAPIConsentStatus? consentStatus;

  List<Object?> _toList() {
    return <Object?>[
      uuid,
      tcData,
      grants,
      euconsent,
      acceptedCategories,
      apply,
      consentStatus,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPIGDPRConsent decode(Object result) {
    result as List<Object?>;
    return HostAPIGDPRConsent(
      uuid: result[0] as String?,
      tcData: (result[1] as Map<Object?, Object?>?)?.cast<String?, String?>(),
      grants: (result[2] as Map<Object?, Object?>?)
          ?.cast<String?, HostAPIGDPRPurposeGrants?>(),
      euconsent: result[3]! as String,
      acceptedCategories: (result[4] as List<Object?>?)?.cast<String?>(),
      apply: result[5]! as bool,
      consentStatus: result[6] as HostAPIConsentStatus?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPIGDPRConsent || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPICCPAConsent {
  HostAPICCPAConsent({
    this.uuid,
    this.rejectedCategories,
    this.rejectedVendors,
    this.status,
    required this.uspstring,
    required this.apply,
  });

  String? uuid;

  List<String?>? rejectedCategories;

  List<String?>? rejectedVendors;

  String? status;

  String uspstring;

  bool apply;

  List<Object?> _toList() {
    return <Object?>[
      uuid,
      rejectedCategories,
      rejectedVendors,
      status,
      uspstring,
      apply,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPICCPAConsent decode(Object result) {
    result as List<Object?>;
    return HostAPICCPAConsent(
      uuid: result[0] as String?,
      rejectedCategories: (result[1] as List<Object?>?)?.cast<String?>(),
      rejectedVendors: (result[2] as List<Object?>?)?.cast<String?>(),
      status: result[3] as String?,
      uspstring: result[4]! as String,
      apply: result[5]! as bool,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPICCPAConsent || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class HostAPISPConsent {
  HostAPISPConsent({
    this.gdpr,
    this.ccpa,
    this.webConsents,
  });

  HostAPIGDPRConsent? gdpr;

  HostAPICCPAConsent? ccpa;

  String? webConsents;

  List<Object?> _toList() {
    return <Object?>[
      gdpr,
      ccpa,
      webConsents,
    ];
  }

  Object encode() {
    return _toList();
  }

  static HostAPISPConsent decode(Object result) {
    result as List<Object?>;
    return HostAPISPConsent(
      gdpr: result[0] as HostAPIGDPRConsent?,
      ccpa: result[1] as HostAPICCPAConsent?,
      webConsents: result[2] as String?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! HostAPISPConsent || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class SPConfig {
  SPConfig({
    required this.accountId,
    required this.propertyId,
    required this.propertyName,
    required this.pmId,
  });

  int accountId;

  int propertyId;

  String propertyName;

  String pmId;

  List<Object?> _toList() {
    return <Object?>[
      accountId,
      propertyId,
      propertyName,
      pmId,
    ];
  }

  Object encode() {
    return _toList();
  }

  static SPConfig decode(Object result) {
    result as List<Object?>;
    return SPConfig(
      accountId: result[0]! as int,
      propertyId: result[1]! as int,
      propertyName: result[2]! as String,
      pmId: result[3]! as String,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! SPConfig || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is HostAPIPMTab) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is HostAPICampaignType) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is HostAPIMessageType) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    } else if (value is HostAPIGranularState) {
      buffer.putUint8(132);
      writeValue(buffer, value.index);
    } else if (value is HostAPIActionType) {
      buffer.putUint8(133);
      writeValue(buffer, value.index);
    } else if (value is HostAPIMessageLanguage) {
      buffer.putUint8(134);
      writeValue(buffer, value.index);
    } else if (value is HostAPICampaignsEnv) {
      buffer.putUint8(135);
      writeValue(buffer, value.index);
    } else if (value is HostAPIConsentAction) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRPurposeGrants) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is HostAPISPError) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGranularStatus) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIConsentStatus) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRConsent) {
      buffer.putUint8(141);
      writeValue(buffer, value.encode());
    } else if (value is HostAPICCPAConsent) {
      buffer.putUint8(142);
      writeValue(buffer, value.encode());
    } else if (value is HostAPISPConsent) {
      buffer.putUint8(143);
      writeValue(buffer, value.encode());
    } else if (value is SPConfig) {
      buffer.putUint8(144);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPIPMTab.values[value];
      case 130:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPICampaignType.values[value];
      case 131:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPIMessageType.values[value];
      case 132:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPIGranularState.values[value];
      case 133:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPIActionType.values[value];
      case 134:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPIMessageLanguage.values[value];
      case 135:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : HostAPICampaignsEnv.values[value];
      case 136:
        return HostAPIConsentAction.decode(readValue(buffer)!);
      case 137:
        return HostAPIGDPRPurposeGrants.decode(readValue(buffer)!);
      case 138:
        return HostAPISPError.decode(readValue(buffer)!);
      case 139:
        return HostAPIGranularStatus.decode(readValue(buffer)!);
      case 140:
        return HostAPIConsentStatus.decode(readValue(buffer)!);
      case 141:
        return HostAPIGDPRConsent.decode(readValue(buffer)!);
      case 142:
        return HostAPICCPAConsent.decode(readValue(buffer)!);
      case 143:
        return HostAPISPConsent.decode(readValue(buffer)!);
      case 144:
        return SPConfig.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class SourcepointUnifiedCmpHostApi {
  /// Constructor for [SourcepointUnifiedCmpHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  SourcepointUnifiedCmpHostApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<HostAPISPConsent> loadMessage({
    required int accountId,
    required int propertyId,
    required String propertyName,
    required String pmId,
    required HostAPIMessageLanguage messageLanguage,
    required HostAPICampaignsEnv campaignsEnv,
    required int messageTimeout,
    required bool runGDPRCampaign,
    required bool runCCPACampaign,
    required bool runUSNATCampaign,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpHostApi.loadMessage$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture =
        pigeonVar_channel.send(<Object?>[
      accountId,
      propertyId,
      propertyName,
      pmId,
      messageLanguage,
      campaignsEnv,
      messageTimeout,
      runGDPRCampaign,
      runCCPACampaign,
      runUSNATCampaign
    ]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as HostAPISPConsent?)!;
    }
  }

  Future<void> loadPrivacyManager({
    required String pmId,
    required HostAPIPMTab pmTab,
    required HostAPICampaignType campaignType,
    required HostAPIMessageType messageType,
  }) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpHostApi.loadPrivacyManager$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel
        .send(<Object?>[pmId, pmTab, campaignType, messageType]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class SourcepointUnifiedCmpFlutterApi {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  void onUIFinished();

  void onUIReady();

  void onError(HostAPISPError error);

  void onConsentReady(HostAPISPConsent consent);

  void onAction(HostAPIConsentAction consentAction);

  void onNoIntentActivitiesFound(String url);

  void onSpFinished(HostAPISPConsent consent);

  static void setUp(
    SourcepointUnifiedCmpFlutterApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onUIFinished$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onUIFinished();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onUIReady$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onUIReady();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onError$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPError? arg_error = (args[0] as HostAPISPError?);
          assert(arg_error != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onError was null, expected non-null HostAPISPError.');
          try {
            api.onError(arg_error!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onConsentReady$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onConsentReady was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPConsent? arg_consent = (args[0] as HostAPISPConsent?);
          assert(arg_consent != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onConsentReady was null, expected non-null HostAPISPConsent.');
          try {
            api.onConsentReady(arg_consent!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onAction$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onAction was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPIConsentAction? arg_consentAction =
              (args[0] as HostAPIConsentAction?);
          assert(arg_consentAction != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onAction was null, expected non-null HostAPIConsentAction.');
          try {
            api.onAction(arg_consentAction!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_url = (args[0] as String?);
          assert(arg_url != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound was null, expected non-null String.');
          try {
            api.onNoIntentActivitiesFound(arg_url!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onSpFinished$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onSpFinished was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPConsent? arg_consent = (args[0] as HostAPISPConsent?);
          assert(arg_consent != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_android.SourcepointUnifiedCmpFlutterApi.onSpFinished was null, expected non-null HostAPISPConsent.');
          try {
            api.onSpFinished(arg_consent!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
