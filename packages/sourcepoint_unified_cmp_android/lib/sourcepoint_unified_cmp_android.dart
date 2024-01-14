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
