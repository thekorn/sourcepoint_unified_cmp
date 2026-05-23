import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

/// A controller for managing Sourcepoint functionality.
class SourcepointController extends ConsentChangeNotifier
    implements AbstractSourcepointConsentController {
  /// A controller for managing Sourcepoint consent management platform.
  ///
  /// The [SourcepointController] is responsible for handling the configuration
  /// and management of the Sourcepoint consent management platform.
  /// It requires a [config] parameter to be provided during initialization.
  SourcepointController({required this.config}) {
    _platform.registerConsentChangeNotifier(this);
  }

  /// The configuration for the Sourcepoint consent management platform.
  @override
  final SPConfig config;

  /// Registers the [delegate] as the event delegate for the Sourcepoint
  @override
  void setEventDelegate(SourcepointEventDelegatePlatform delegate) {
    _platform.registerEventDelegate(delegate);
  }

  /// Loading a Privacy Manager on demand
  /// consent changes will propagated via controller
  @override
  Future<void> loadPrivacyManager({
    required String pmId,
    PMTab pmTab = PMTab.purposes,
    CampaignType campaignType = CampaignType.gdpr,
    MessageType messageType = MessageType.mobile,
  }) async {
    debugPrint('loadPrivacyManager');
    return _platform.loadPrivacyManager(pmId, pmTab, campaignType, messageType);
  }

  /// Loading the First Layer Message
  /// and returns the initial consent status
  @override
  Future<SPConsent> loadMessage() async {
    debugPrint('loadMessage');
    return _platform.loadMessage(config);
  }

  /// Programmatically grant custom GDPR consent to the supplied [vendors],
  /// [categories] and [legIntCategories].
  ///
  /// The native SDK persists the consent locally and the registered
  /// [ConsentChangeNotifier] / event delegate callbacks are notified about the
  /// updated [SPConsent].
  @override
  Future<SPConsent> customConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  }) {
    debugPrint('customConsentGdpr');
    return _platform.customConsentGdpr(
      vendors: vendors,
      categories: categories,
      legIntCategories: legIntCategories,
    );
  }

  /// Programmatically delete custom GDPR consent for the supplied [vendors],
  /// [categories] and [legIntCategories].
  ///
  /// The native SDK persists the consent locally and the registered
  /// [ConsentChangeNotifier] / event delegate callbacks are notified about the
  /// updated [SPConsent].
  @override
  Future<SPConsent> deleteCustomConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  }) {
    debugPrint('deleteCustomConsentGdpr');
    return _platform.deleteCustomConsentGdpr(
      vendors: vendors,
      categories: categories,
      legIntCategories: legIntCategories,
    );
  }
}
