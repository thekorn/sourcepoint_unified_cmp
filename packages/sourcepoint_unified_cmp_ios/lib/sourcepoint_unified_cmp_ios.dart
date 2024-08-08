import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sourcepoint_unified_cmp_ios/src/messages.g.dart' as messages;
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

extension on MessageLanguage {
  messages.HostAPIMessageLanguage toHostAPIMessageLanguage() {
    switch (this) {
      case MessageLanguage.english:
        return messages.HostAPIMessageLanguage.english;
      case MessageLanguage.french:
        return messages.HostAPIMessageLanguage.french;
      case MessageLanguage.german:
        return messages.HostAPIMessageLanguage.german;
      case MessageLanguage.italian:
        return messages.HostAPIMessageLanguage.italian;
      case MessageLanguage.spanish:
        return messages.HostAPIMessageLanguage.spanish;
    }
  }
}

extension on CampaignsEnv {
  messages.HostAPICampaignsEnv toHostAPICampaignsEnv() {
    switch (this) {
      case CampaignsEnv.stage:
        return messages.HostAPICampaignsEnv.stage;
      case CampaignsEnv.public:
        return messages.HostAPICampaignsEnv.publicEnv;
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

extension on messages.HostAPISPError {
  SPError toSPError() {
    return SPError(
      spCode: spCode,
      description: description,
    );
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
      webConsents: webConsents,
    );
  }
}

extension on PMTab {
  messages.HostAPIPMTab toHostAPIPMTab() {
    switch (this) {
      case PMTab.purposes:
        return messages.HostAPIPMTab.purposes;
      case PMTab.defaults:
        return messages.HostAPIPMTab.defaults;
      case PMTab.vendors:
        return messages.HostAPIPMTab.vendors;
      case PMTab.features:
        return messages.HostAPIPMTab.features;
    }
  }
}

extension on CampaignType {
  messages.HostAPICampaignType toHostAPICampaignType() {
    switch (this) {
      case CampaignType.gdpr:
        return messages.HostAPICampaignType.gdpr;
      case CampaignType.ccpa:
        return messages.HostAPICampaignType.ccpa;
      case CampaignType.usnat:
        // FIXME: Handle this case.
        throw UnimplementedError();
    }
  }
}

extension on MessageType {
  messages.HostAPIMessageType toHostAPIMessageType() {
    switch (this) {
      case MessageType.mobile:
        return messages.HostAPIMessageType.mobile;
      case MessageType.legacyOtt:
        return messages.HostAPIMessageType.legacyOtt;
      case MessageType.ott:
        return messages.HostAPIMessageType.ott;
    }
  }
}

/// The iOS implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpIOS extends SourcepointUnifiedCmpPlatform {
  final messages.SourcepointUnifiedCmpHostApi _api =
      messages.SourcepointUnifiedCmpHostApi();
  ConsentChangeNotifier? _notifier;
  SourcepointEventDelegatePlatform? _delegate;

  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpIOS();
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    assert(
      _delegate == null,
      'EventDelegate already set, you can only have one delegate at a time.',
    );
    messages.SourcepointUnifiedCmpFlutterApi.setUp(
      SourcepointEventHandler(
        delegate: delegate,
        consentChangeNotifier: _notifier,
      ),
    );
    _delegate = delegate;
  }

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    assert(config.campaigns.isNotEmpty, 'campaigns cannot be empty');
    final hostConsent = await _api.loadMessage(
      accountId: config.accountId,
      propertyId: config.propertyId,
      propertyName: config.propertyName,
      pmId: config.pmId,
      messageLanguage: config.messageLanguage.toHostAPIMessageLanguage(),
      campaignsEnv: config.campaignsEnv.toHostAPICampaignsEnv(),
      messageTimeout: config.messageTimeout,
      runCCPACampaign: config.campaigns.contains(CampaignType.ccpa),
      runGDPRCampaign: config.campaigns.contains(CampaignType.gdpr),
    );
    final consent = hostConsent.toSPConsent();
    return consent;
  }

  @override
  Future<void> loadPrivacyManager(
    String pmId,
    PMTab pmTab,
    CampaignType campaignType,
    MessageType messageType,
  ) async {
    debugPrint('loadPrivacyManager');
    await _api.loadPrivacyManager(
      pmId: pmId,
      pmTab: pmTab.toHostAPIPMTab(),
      campaignType: campaignType.toHostAPICampaignType(),
      messageType: messageType.toHostAPIMessageType(),
    );
  }

  @override
  void registerConsentChangeNotifier(ConsentChangeNotifier notifier) {
    assert(_notifier == null, 'ConsentChangeNotifier already set');
    messages.SourcepointUnifiedCmpFlutterApi.setUp(
      SourcepointEventHandler(
        delegate: _delegate,
        consentChangeNotifier: notifier,
      ),
    );
    _notifier = notifier;
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
  SourcepointEventHandler({
    SourcepointEventDelegatePlatform? delegate,
    ConsentChangeNotifier? consentChangeNotifier,
  })  : _consentChangeNotifier = consentChangeNotifier,
        _delegate = delegate;

  /// The delegate for handling Sourcepoint events in the Sourcepoint
  /// Unified CMP Android library.
  final SourcepointEventDelegatePlatform? _delegate;
  final ConsentChangeNotifier? _consentChangeNotifier;

  @override
  void onAction(String viewId, messages.HostAPIConsentAction consentAction) {
    // FIXME: generalize android=int, ios=string
    _delegate?.onAction?.call(0, consentAction.toConsentAction());
  }

  @override
  void onConsentReady(messages.HostAPISPConsent consent) {
    _delegate?.onConsentReady?.call(consent.toSPConsent());
    // Also notify the consent change notifier about the new consent
    _consentChangeNotifier?.updateConsent(consent.toSPConsent());
  }

  @override
  void onError(messages.HostAPISPError error) {
    _delegate?.onError?.call(error.toSPError());
  }

  @override
  void onNoIntentActivitiesFound(String url) {
    _delegate?.onNoIntentActivitiesFound?.call(url);
  }

  @override
  void onSpFinished(messages.HostAPISPConsent consent) {
    _delegate?.onSpFinished?.call(consent.toSPConsent());
  }

  @override
  void onUIFinished(String viewId) {
    // FIXME: generalize android=int, ios=string
    _delegate?.onUIFinished?.call(0);
  }

  @override
  void onUIReady(String viewId) {
    // FIXME: generalize android=int, ios=string
    _delegate?.onUIReady?.call(0);
  }
}
