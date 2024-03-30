import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

/// A controller for managing Sourcepoint functionality.
class SourcepointController extends ConsentChangeNotifier {
  /// A controller for managing Sourcepoint consent management platform.
  ///
  /// The [SourcepointController] is responsible for handling the configuration
  /// and management of the Sourcepoint consent management platform.
  /// It requires a [config] parameter to be provided during initialization.
  SourcepointController({required this.config}) {
    _platform.registerConsentChangeNotifier(this);
  }

  /// The configuration for the Sourcepoint consent management platform.
  final SPConfig config;

  SourcepointEventDelegatePlatform? _delegate;

  /// Registers the [delegate] as the event delegate for the Sourcepoint
  void setEventDelegate(SourcepointEventDelegatePlatform delegate) {
    assert(
      _delegate == null,
      'EventDelegate already set, you can only have one delegate at a time.',
    );
    _platform.registerEventDelegate(delegate);
    _delegate = delegate;
  }

  /// Loading a Privacy Manager on demand
  /// consent changes will propagated via controller
  Future<void> loadPrivacyManager({
    required String pmId,
    PMTab pmTab = PMTab.purposes,
    CampaignType campaignType = CampaignType.gdpr,
    MessageType messageType = MessageType.mobile,
  }) async {
    debugPrint('loadPrivacyManager');
    return _platform.loadPrivacyManager(
      pmId,
      pmTab,
      campaignType,
      messageType,
    );
  }

  /// Loading the First Layer Message
  /// and returns the initial consent status
  Future<SPConsent> loadMessage() async {
    debugPrint('loadMessage');
    return _platform.loadMessage(config);
  }
}
