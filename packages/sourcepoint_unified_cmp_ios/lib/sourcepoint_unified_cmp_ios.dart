import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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

extension on PMTab {
  messages.HostAPIPMTab toHostAPIPMTab() {
    switch (this) {
      case PMTab.purposes:
        return messages.HostAPIPMTab.purposes;
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
    }
  }
}

extension on MessageType {
  messages.HostAPIMessageType toHostAPIMessageType() {
    switch (this) {
      case MessageType.mobile:
        return messages.HostAPIMessageType.mobile;
      case MessageType.lagacyOtt:
        return messages.HostAPIMessageType.lagacyOtt;
      case MessageType.ott:
        return messages.HostAPIMessageType.ott;
    }
  }
}

/// The iOS implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpIOS extends SourcepointUnifiedCmpPlatform {
  final messages.SourcepointUnifiedCmpHostApi _api =
      messages.SourcepointUnifiedCmpHostApi();

  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpIOS();
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    // TODO: implement registerEventDelegate

    //messages.SourcepointUnifiedCmpFlutterApi.setup(
    //  SourcepointEventHandler(delegate: delegate),
    //);
    debugPrint("registerEventDelegate");
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
    //await _api.loadPrivacyManager(
    //  pmId: pmId,
    //  pmTab: pmTab.toHostAPIPMTab(),
    //  campaignType: campaignType.toHostAPICampaignType(),
    //  messageType: messageType.toHostAPIMessageType(),
    //);
    debugPrint("loadPrivacyManager");
  }
}
