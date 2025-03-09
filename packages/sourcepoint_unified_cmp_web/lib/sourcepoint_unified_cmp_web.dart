import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_web/js_loader.dart';

/// The Web implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpWeb extends SourcepointUnifiedCmpPlatform {
  late SPWebApi _webApi;
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
    SPWebApi.setUp(
      SourcepointEventHandler(
        delegate: delegate,
        consentChangeNotifier: _notifier,
      ),
    );
    _delegate = delegate;
  }

  @override
  Future<SPConsent> loadMessage(SPConfig config) async {
    _webApi = SPWebApi(config);
    final consent = await _webApi.loadMessage();
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
    await _webApi.loadPrivacyManager(pmId, pmTab, campaignType, messageType);
  }

  @override
  void registerConsentChangeNotifier(ConsentChangeNotifier notifier) {
    assert(_notifier == null, 'ConsentChangeNotifier already set');
    SPWebApi.setUp(
      SourcepointEventHandler(
        delegate: _delegate,
        consentChangeNotifier: notifier,
      ),
    );
    _notifier = notifier;
  }
}
