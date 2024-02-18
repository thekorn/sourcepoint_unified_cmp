// Autogenerated from Pigeon (v16.0.5), do not edit directly.
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

enum HostAPIPMTab {
  purposes,
}

enum HostAPICampaignType {
  gdpr,
  ccpa,
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
}

enum HostAPICampaignsEnv {
  stage,
  publicEnv,
}

class HostAPISPError {
  HostAPISPError({
    required this.spCode,
    required this.description,
  });

  String spCode;

  String description;

  Object encode() {
    return <Object?>[
      spCode,
      description,
    ];
  }

  static HostAPISPError decode(Object result) {
    result as List<Object?>;
    return HostAPISPError(
      spCode: result[0]! as String,
      description: result[1]! as String,
    );
  }
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

  Object encode() {
    return <Object?>[
      actionType.index,
      pubData,
      campaignType.index,
      customActionId,
    ];
  }

  static HostAPIConsentAction decode(Object result) {
    result as List<Object?>;
    return HostAPIConsentAction(
      actionType: HostAPIActionType.values[result[0]! as int],
      pubData: result[1]! as String,
      campaignType: HostAPICampaignType.values[result[2]! as int],
      customActionId: result[3] as String?,
    );
  }
}

class HostAPIGDPRPurposeGrants {
  HostAPIGDPRPurposeGrants({
    required this.granted,
    this.purposeGrants,
  });

  bool granted;

  Map<String?, bool?>? purposeGrants;

  Object encode() {
    return <Object?>[
      granted,
      purposeGrants,
    ];
  }

  static HostAPIGDPRPurposeGrants decode(Object result) {
    result as List<Object?>;
    return HostAPIGDPRPurposeGrants(
      granted: result[0]! as bool,
      purposeGrants:
          (result[1] as Map<Object?, Object?>?)?.cast<String?, bool?>(),
    );
  }
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

  Object encode() {
    return <Object?>[
      defaultConsent,
      previousOptInAll,
      purposeConsent?.index,
      purposeLegInt?.index,
      vendorConsent?.index,
      vendorLegInt?.index,
    ];
  }

  static HostAPIGranularStatus decode(Object result) {
    result as List<Object?>;
    return HostAPIGranularStatus(
      defaultConsent: result[0] as bool?,
      previousOptInAll: result[1] as bool?,
      purposeConsent: result[2] != null
          ? HostAPIGranularState.values[result[2]! as int]
          : null,
      purposeLegInt: result[3] != null
          ? HostAPIGranularState.values[result[3]! as int]
          : null,
      vendorConsent: result[4] != null
          ? HostAPIGranularState.values[result[4]! as int]
          : null,
      vendorLegInt: result[5] != null
          ? HostAPIGranularState.values[result[5]! as int]
          : null,
    );
  }
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

  Object encode() {
    return <Object?>[
      consentedAll,
      consentedToAny,
      granularStatus?.encode(),
      hasConsentData,
      rejectedAny,
      rejectedLI,
      legalBasisChanges,
      vendorListAdditions,
    ];
  }

  static HostAPIConsentStatus decode(Object result) {
    result as List<Object?>;
    return HostAPIConsentStatus(
      consentedAll: result[0] as bool?,
      consentedToAny: result[1] as bool?,
      granularStatus: result[2] != null
          ? HostAPIGranularStatus.decode(result[2]! as List<Object?>)
          : null,
      hasConsentData: result[3] as bool?,
      rejectedAny: result[4] as bool?,
      rejectedLI: result[5] as bool?,
      legalBasisChanges: result[6] as bool?,
      vendorListAdditions: result[7] as bool?,
    );
  }
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

  Object encode() {
    return <Object?>[
      uuid,
      tcData,
      grants,
      euconsent,
      acceptedCategories,
      apply,
      consentStatus?.encode(),
    ];
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
      consentStatus: result[6] != null
          ? HostAPIConsentStatus.decode(result[6]! as List<Object?>)
          : null,
    );
  }
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

  Object encode() {
    return <Object?>[
      uuid,
      rejectedCategories,
      rejectedVendors,
      status,
      uspstring,
      apply,
    ];
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
}

class HostAPISPConsent {
  HostAPISPConsent({
    this.gdpr,
    this.ccpa,
  });

  HostAPIGDPRConsent? gdpr;

  HostAPICCPAConsent? ccpa;

  Object encode() {
    return <Object?>[
      gdpr?.encode(),
      ccpa?.encode(),
    ];
  }

  static HostAPISPConsent decode(Object result) {
    result as List<Object?>;
    return HostAPISPConsent(
      gdpr: result[0] != null
          ? HostAPIGDPRConsent.decode(result[0]! as List<Object?>)
          : null,
      ccpa: result[1] != null
          ? HostAPICCPAConsent.decode(result[1]! as List<Object?>)
          : null,
    );
  }
}

class _SourcepointUnifiedCmpHostApiCodec extends StandardMessageCodec {
  const _SourcepointUnifiedCmpHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is HostAPICCPAConsent) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIConsentStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRConsent) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRPurposeGrants) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGranularStatus) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is HostAPISPConsent) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return HostAPICCPAConsent.decode(readValue(buffer)!);
      case 129:
        return HostAPIConsentStatus.decode(readValue(buffer)!);
      case 130:
        return HostAPIGDPRConsent.decode(readValue(buffer)!);
      case 131:
        return HostAPIGDPRPurposeGrants.decode(readValue(buffer)!);
      case 132:
        return HostAPIGranularStatus.decode(readValue(buffer)!);
      case 133:
        return HostAPISPConsent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class SourcepointUnifiedCmpHostApi {
  /// Constructor for [SourcepointUnifiedCmpHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  SourcepointUnifiedCmpHostApi({BinaryMessenger? binaryMessenger})
      : __pigeon_binaryMessenger = binaryMessenger;
  final BinaryMessenger? __pigeon_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec =
      _SourcepointUnifiedCmpHostApiCodec();

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
  }) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpHostApi.loadMessage';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[
      accountId,
      propertyId,
      propertyName,
      pmId,
      messageLanguage.index,
      campaignsEnv.index,
      messageTimeout,
      runGDPRCampaign,
      runCCPACampaign
    ]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as HostAPISPConsent?)!;
    }
  }

  Future<void> loadPrivacyManager({
    required String pmId,
    required HostAPIPMTab pmTab,
    required HostAPICampaignType campaignType,
    required HostAPIMessageType messageType,
  }) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpHostApi.loadPrivacyManager';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel.send(
            <Object?>[pmId, pmTab.index, campaignType.index, messageType.index])
        as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }
}

class _SourcepointUnifiedCmpFlutterApiCodec extends StandardMessageCodec {
  const _SourcepointUnifiedCmpFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is HostAPICCPAConsent) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIConsentAction) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIConsentStatus) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRConsent) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGDPRPurposeGrants) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is HostAPIGranularStatus) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is HostAPISPConsent) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is HostAPISPError) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return HostAPICCPAConsent.decode(readValue(buffer)!);
      case 129:
        return HostAPIConsentAction.decode(readValue(buffer)!);
      case 130:
        return HostAPIConsentStatus.decode(readValue(buffer)!);
      case 131:
        return HostAPIGDPRConsent.decode(readValue(buffer)!);
      case 132:
        return HostAPIGDPRPurposeGrants.decode(readValue(buffer)!);
      case 133:
        return HostAPIGranularStatus.decode(readValue(buffer)!);
      case 134:
        return HostAPISPConsent.decode(readValue(buffer)!);
      case 135:
        return HostAPISPError.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class SourcepointUnifiedCmpFlutterApi {
  static const MessageCodec<Object?> pigeonChannelCodec =
      _SourcepointUnifiedCmpFlutterApiCodec();

  void onUIFinished(String viewId);

  void onUIReady(String viewId);

  void onError(HostAPISPError error);

  void onConsentReady(HostAPISPConsent consent);

  void onAction(String viewId, HostAPIConsentAction consentAction);

  void onNoIntentActivitiesFound(String url);

  void onSpFinished(HostAPISPConsent consent);

  static void setup(SourcepointUnifiedCmpFlutterApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIFinished',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIFinished was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_viewId = (args[0] as String?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIFinished was null, expected non-null String.');
          try {
            api.onUIFinished(arg_viewId!);
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIReady',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIReady was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_viewId = (args[0] as String?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onUIReady was null, expected non-null String.');
          try {
            api.onUIReady(arg_viewId!);
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onError',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPError? arg_error = (args[0] as HostAPISPError?);
          assert(arg_error != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onError was null, expected non-null HostAPISPError.');
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onConsentReady',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onConsentReady was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPConsent? arg_consent = (args[0] as HostAPISPConsent?);
          assert(arg_consent != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onConsentReady was null, expected non-null HostAPISPConsent.');
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onAction',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onAction was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_viewId = (args[0] as String?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onAction was null, expected non-null String.');
          final HostAPIConsentAction? arg_consentAction =
              (args[1] as HostAPIConsentAction?);
          assert(arg_consentAction != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onAction was null, expected non-null HostAPIConsentAction.');
          try {
            api.onAction(arg_viewId!, arg_consentAction!);
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_url = (args[0] as String?);
          assert(arg_url != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onNoIntentActivitiesFound was null, expected non-null String.');
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
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onSpFinished',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onSpFinished was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final HostAPISPConsent? arg_consent = (args[0] as HostAPISPConsent?);
          assert(arg_consent != null,
              'Argument for dev.flutter.pigeon.sourcepoint_unified_cmp_ios.SourcepointUnifiedCmpFlutterApi.onSpFinished was null, expected non-null HostAPISPConsent.');
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
