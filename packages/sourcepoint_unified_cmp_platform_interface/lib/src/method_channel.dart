import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/change_notifier.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

/// An implementation of [SourcepointUnifiedCmpPlatform] that uses method
/// channels.
class MethodChannelSourcepointUnifiedCmp extends SourcepointUnifiedCmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sourcepoint_unified_cmp');
  SourcepointEventDelegatePlatform? _delegate;
  ConsentChangeNotifier? _notifier;

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    return (await methodChannel.invokeMethod<SPConsent>('loadMessage', [
      config,
    ]))!;
  }

  @override
  Future<void> loadPrivacyManager(
    String pmId,
    PMTab pmTab,
    CampaignType campaignType,
    MessageType messageType,
  ) async {
    await methodChannel.invokeMethod<void>('loadPrivacyManager');
  }

  @override
  void registerConsentChangeNotifier(ConsentChangeNotifier notifier) {
    assert(_notifier == null, 'ConsentChangeNotifier already set');
    _notifier = notifier;
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    assert(
      _delegate == null,
      'EventDelegate already set, you can only have one delegate at a time.',
    );
    _delegate = delegate;
  }
}
