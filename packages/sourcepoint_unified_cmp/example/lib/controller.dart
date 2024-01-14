import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_example/types.dart';

class MockController {
  MockController({required this.config});
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
    debugPrint('load');
    return SPConsent();
  }
}
