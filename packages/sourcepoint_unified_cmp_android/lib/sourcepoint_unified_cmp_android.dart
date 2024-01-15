import 'dart:convert';

import 'package:sourcepoint_unified_cmp_android/src/messages.g.dart'
    as messages;
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

extension on messages.HostAPIGranularState {
  GranularState toGranularState() {
    switch (this) {
      case messages.HostAPIGranularState.all:
        return GranularState.all;
      case messages.HostAPIGranularState.some:
        return GranularState.some;
      case messages.HostAPIGranularState.none:
        return GranularState.none;
    }
  }
}

extension on messages.HostAPICampaignType {
  CampaignType toCampaignType() {
    switch (this) {
      case messages.HostAPICampaignType.gdpr:
        return CampaignType.gdpr;
      case messages.HostAPICampaignType.ccpa:
        return CampaignType.ccpa;
    }
  }
}

extension on messages.HostAPIActionType {
  ActionType toActionType() {
    switch (this) {
      case messages.HostAPIActionType.showOptions:
        return ActionType.showOptions;
      case messages.HostAPIActionType.rejectAll:
        return ActionType.rejectAll;
      case messages.HostAPIActionType.acceptAll:
        return ActionType.acceptAll;
      case messages.HostAPIActionType.msgCancel:
        return ActionType.msgCancel;
      case messages.HostAPIActionType.custom:
        return ActionType.custom;
      case messages.HostAPIActionType.saveAndExit:
        return ActionType.saveAndExit;
      case messages.HostAPIActionType.pmDismiss:
        return ActionType.pmDismiss;
      case messages.HostAPIActionType.getMsgError:
        return ActionType.getMsgError;
      case messages.HostAPIActionType.getMessageNotCalled:
        return ActionType.getMessageNotCalled;
      case messages.HostAPIActionType.unknown:
        return ActionType.unknown;
    }
  }
}

extension on messages.HostAPIConsentAction {
  ConsentAction toConsentAction() {
    return ConsentAction(
      actionType: actionType.toActionType(),
      pubData: jsonDecode(pubData),
      campaignType: campaignType.toCampaignType(),
    );
  }
}

extension on messages.HostAPISourcepointUnifiedCmpError {
  SourcepointUnifiedCmpError toSourcepointUnifiedCMPError() {
    switch (this) {
      case messages.HostAPISourcepointUnifiedCmpError.invalidArgumentException:
        return SourcepointUnifiedCmpError.invalidArgumentException;
      case messages.HostAPISourcepointUnifiedCmpError.missingPropertyException:
        return SourcepointUnifiedCmpError.missingPropertyException;
      case messages.HostAPISourcepointUnifiedCmpError.invalidConsentResponse:
        return SourcepointUnifiedCmpError.invalidConsentResponse;
      case messages
            .HostAPISourcepointUnifiedCmpError.noInternetConnectionException:
        return SourcepointUnifiedCmpError.noInternetConnectionException;
      case messages.HostAPISourcepointUnifiedCmpError
            .executionInTheWrongThreadException:
        return SourcepointUnifiedCmpError.executionInTheWrongThreadException;
      case messages.HostAPISourcepointUnifiedCmpError.requestFailedException:
        return SourcepointUnifiedCmpError.requestFailedException;
      case messages.HostAPISourcepointUnifiedCmpError.invalidRequestException:
        return SourcepointUnifiedCmpError.invalidRequestException;
    }
  }
}

extension on messages.HostAPIGranularStatus {
  GranularStatus toGranularStatus() {
    return GranularStatus(
      defaultConsent: defaultConsent,
      previousOptInAll: previousOptInAll,
      purposeConsent: purposeConsent?.toGranularState(),
      purposeLegInt: purposeLegInt?.toGranularState(),
      vendorConsent: vendorConsent?.toGranularState(),
      vendorLegInt: vendorLegInt?.toGranularState(),
    );
  }
}

extension on messages.HostAPIConsentStatus {
  ConsentStatus toConsentStatus() {
    return ConsentStatus(
      consentedAll: consentedAll,
      consentedToAny: consentedToAny,
      granularStatus: granularStatus?.toGranularStatus(),
      hasConsentData: hasConsentData,
      rejectedAny: rejectedAny,
      rejectedLI: rejectedLI,
      legalBasisChanges: legalBasisChanges,
      vendorListAdditions: vendorListAdditions,
    );
  }
}

extension on messages.HostAPIGDPRPurposeGrants {
  GDPRPurposeGrants toGDPRPurposeGrants() {
    final filteredPurposeGrants = <String, bool>{};
    purposeGrants?.forEach((key, value) {
      if (value != null && key != null) {
        filteredPurposeGrants[key] = value;
      }
    });
    return GDPRPurposeGrants(
      granted: granted,
      purposeGrants: filteredPurposeGrants,
    );
  }
}

extension on messages.HostAPIGDPRConsent {
  GDPRConsent toGDPRConsent() {
    final filteredGrants = <String, GDPRPurposeGrants>{};
    grants?.forEach((key, value) {
      if (value != null && key != null) {
        filteredGrants[key] = value.toGDPRPurposeGrants();
      }
    });
    final filteredTcData = <String, String>{};
    tcData?.forEach((key, value) {
      if (value != null && key != null) {
        filteredTcData[key] = value;
      }
    });
    tcData?.removeWhere((key, value) => key == null || value == null);
    return GDPRConsent(
      tcData: filteredTcData,
      grants: filteredGrants,
      euconsent: euconsent,
      acceptedCategories:
          acceptedCategories?.whereType<String>().toList() ?? [],
      apply: apply,
      consentStatus: consentStatus?.toConsentStatus(),
      uuid: uuid,
    );
  }
}

extension on messages.HostAPISPConsent {
  SPConsent toSPConsent() {
    return SPConsent(
      gdpr: gdpr?.toGDPRConsent(),
    );
  }
}

/// The Android implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpAndroid extends SourcepointUnifiedCmpPlatform {
  final messages.SourcepointUnifiedCmpHostApi _api =
      messages.SourcepointUnifiedCmpHostApi();

  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpAndroid();
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    messages.SourcepointUnifiedCmpFlutterApi.setup(
      SourcepointEventHandler(delegate: delegate),
    );
  }

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    final hostConsent = await _api.loadMessage(
      accountId: config.accountId,
      propertyId: config.propertyId,
      propertyName: config.propertyName,
      pmId: config.pmId,
    );
    final consent = hostConsent.toSPConsent();
    return consent;
  }
}

/// This class represents the event handler for Sourcepoint in the Android
/// platform.
class SourcepointEventHandler
    implements messages.SourcepointUnifiedCmpFlutterApi {
  /// A class representing a Sourcepoint event handler.
  ///
  /// This class is responsible for handling events related to Sourcepoint.
  /// It requires a [delegate] parameter, which is an object that implements the
  /// necessary methods to handle the events.
  SourcepointEventHandler({required this.delegate});

  /// The delegate for handling Sourcepoint events in the Sourcepoint
  /// Unified CMP Android library.
  final SourcepointEventDelegatePlatform delegate;

  @override
  void onAction(int viewId, messages.HostAPIConsentAction consentAction) {
    if (delegate.onAction != null) {
      delegate.onAction?.call(viewId, consentAction.toConsentAction());
    }
  }

  @override
  void onConsentReady(messages.HostAPISPConsent consent) {
    if (delegate.onConsentReady != null) {
      delegate.onConsentReady?.call(consent.toSPConsent());
    }
  }

  @override
  void onError(messages.HostAPISourcepointUnifiedCmpError error) {
    if (delegate.onError != null) {
      delegate.onError?.call(error.toSourcepointUnifiedCMPError());
    }
  }

  @override
  void onNoIntentActivitiesFound(String url) {
    if (delegate.onNoIntentActivitiesFound != null) {
      delegate.onNoIntentActivitiesFound?.call(url);
    }
  }

  @override
  void onSpFinished(messages.HostAPISPConsent consent) {
    if (delegate.onSpFinished != null) {
      delegate.onSpFinished?.call(consent.toSPConsent());
    }
  }

  @override
  void onUIFinished(int viewId) {
    if (delegate.onUIFinished != null) {
      delegate.onUIFinished?.call(viewId);
    }
  }

  @override
  void onUIReady(int viewId) {
    if (delegate.onUIReady != null) {
      delegate.onUIReady?.call(viewId);
    }
  }
}
