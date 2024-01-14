import 'package:sourcepoint_unified_cmp_android/src/messages.g.dart'
    as messages;
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// The Android implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpAndroid extends SourcepointUnifiedCmpPlatform {
  final messages.SourcepointUnifiedCmpApi _api =
      messages.SourcepointUnifiedCmpApi();

  /// Registers this class as the default instance
  /// of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpAndroid();
  }

  @override
  Future<void> loadPrivacyManager(SPConfig config) {
    return _api.loadPrivacyManager(
      accountId: config.accountId,
      propertyId: config.propertyId,
      propertyName: config.propertyName,
      pmId: config.pmId,
    );
  }

  @override
  Future<void> load(SPConfig config) {
    return _api.loadPrivacyManager(
      accountId: config.accountId,
      propertyId: config.propertyId,
      propertyName: config.propertyName,
      pmId: config.pmId,
    );
  }

  @override
  Future<void> init(SPConfig config) {
    return _api.init(
      accountId: config.accountId,
      propertyId: config.propertyId,
      propertyName: config.propertyName,
      pmId: config.pmId,
    );
  }
}
