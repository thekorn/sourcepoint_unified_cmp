import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

export 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

/// A controller for managing Sourcepoint functionality.
class SourcepointController {
  /// A controller for managing Sourcepoint consent management platform.
  ///
  /// The [SourcepointController] is responsible for handling the configuration
  /// and management of the Sourcepoint consent management platform.
  /// It requires a [config] parameter to be provided during initialization.
  SourcepointController({required this.config});

  /// The configuration for the Sourcepoint consent management platform.
  final SPConfig config;

  /// The delegate for handling Sourcepoint events in the Sourcepoint
  SourcepointEventDelegate? delegate;

  /// Registers the [delegate] as the event delegate for the Sourcepoint
  void setEventDelegate(SourcepointEventDelegate delegate) {
    _platform.registerEventDelegate(delegate);
  }

  /// Loading a Privacy Manager on demand
  /// consent chnages will propagated via controller
  Future<void> loadPrivacyManager({
    required String pmId,
    PMTab pmTab = PMTab.purposes,
    CampaignType campaignType = CampaignType.gdpr,
    MessageType messageType = MessageType.mobile,
  }) async {
    debugPrint('loadPrivacyManager');
  }

  /// Loading the First Layer Message
  /// and returns the inital consent status
  Future<SPConsent> loadMessage() async {
    debugPrint('loadMessage');
    return _platform.loadMessage(config);
  }
}

/// A delegate class for handling Sourcepoint events.
/// This class implements the SourcepointEventDelegatePlatform interface.
class SourcepointEventDelegate implements SourcepointEventDelegatePlatform {
  /// A delegate class for handling Sourcepoint events.
  SourcepointEventDelegate({
    this.onConsentReady,
    this.onUIReady,
    this.onAction,
    this.onError,
    this.onNoIntentActivitiesFound,
    this.onSpFinished,
    this.onUIFinished,
  });
  @override
  final void Function(SPConsent)? onConsentReady;

  @override
  final void Function(int viewId, ConsentAction consentAction)? onAction;

  @override
  final void Function(SourcepointUnifiedCmpError error)? onError;

  @override
  final void Function(String url)? onNoIntentActivitiesFound;

  @override
  final void Function(SPConsent consent)? onSpFinished;

  @override
  final void Function(int viewId)? onUIFinished;

  @override
  final void Function(int viewId)? onUIReady;
}
