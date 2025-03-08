import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// The Web implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpWeb extends SourcepointUnifiedCmpPlatform {
  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith([Object? registrar]) {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpWeb();
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    throw UnimplementedError(
      'registerEventDelegate is not implemented for web',
    );
  }

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    throw UnimplementedError('loadMessage is not implemented for web');
  }

  @override
  Future<void> loadPrivacyManager(
    String pmId,
    PMTab pmTab,
    CampaignType campaignType,
    MessageType messageType,
  ) async {
    debugPrint('loadPrivacyManager');
    throw UnimplementedError('loadPrivacyManager is not implemented for web');
  }

  @override
  void registerConsentChangeNotifier(ConsentChangeNotifier notifier) {
    throw UnimplementedError(
      'registerConsentChangeNotifier is not implemented for web',
    );
  }
}
