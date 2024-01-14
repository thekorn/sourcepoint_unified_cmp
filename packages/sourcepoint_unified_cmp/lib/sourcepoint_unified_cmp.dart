// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

export 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

class SourcepointController {
  SourcepointController({required this.config});
  final SPConfig config;

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
