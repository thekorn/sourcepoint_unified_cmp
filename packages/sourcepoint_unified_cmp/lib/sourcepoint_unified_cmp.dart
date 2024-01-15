// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

export 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

class SourcepointController {
  SourcepointController({required this.config});
  final SPConfig config;
  SourcepointEventDelegate? delegate;

  // ignore: use_setters_to_change_properties
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

class SourcepointEventDelegate implements SourcepointEventDelegatePlatform {
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
