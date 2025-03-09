import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_web/js_loader.dart';

/// The Web implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpWeb extends SourcepointUnifiedCmpPlatform {
  ConsentChangeNotifier? _notifier;
  SourcepointEventDelegatePlatform? _delegate;

  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith([Object? registrar]) {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpWeb();
  }

  @override
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    assert(
      _delegate == null,
      'EventDelegate already set, you can only have one delegate at a time.',
    );
    //messages.SourcepointUnifiedCmpFlutterApi.setUp(
    //  SourcepointEventHandler(
    //    delegate: delegate,
    //    consentChangeNotifier: _notifier,
    //  ),
    //);
    _delegate = delegate;
  }

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    final consent = await loadWebSdk(config);
    return consent;
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
    assert(_notifier == null, 'ConsentChangeNotifier already set');
    //messages.SourcepointUnifiedCmpFlutterApi.setUp(
    //  SourcepointEventHandler(
    //    delegate: _delegate,
    //    consentChangeNotifier: notifier,
    //  ),
    //);
    _notifier = notifier;
  }
}
