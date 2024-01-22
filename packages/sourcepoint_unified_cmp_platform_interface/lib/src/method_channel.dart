import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

/// An implementation of [SourcepointUnifiedCmpPlatform] that uses method
/// channels.
class MethodChannelSourcepointUnifiedCmp extends SourcepointUnifiedCmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sourcepoint_unified_cmp');

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    return (await methodChannel.invokeMethod<SPConsent>('loadMessage')) ??
        SPConsent();
  }

  @override
  Future<void> loadPrivacyManager(
    String pmId,
    PMTab pmTab,
    CampaignType campaignType,
    MessageType messageType,
  ) async {
    await methodChannel.invokeMethod<SPConsent>('loadPrivacyManager');
  }
}
