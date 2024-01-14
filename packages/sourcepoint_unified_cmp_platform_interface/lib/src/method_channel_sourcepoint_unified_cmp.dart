import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// An implementation of [SourcepointUnifiedCmpPlatform] that uses method
/// channels.
class MethodChannelSourcepointUnifiedCmp extends SourcepointUnifiedCmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sourcepoint_unified_cmp');

  @override
  Future<void> loadPrivacyManager(SPConfig config) {
    return methodChannel.invokeMethod<String>('loadPrivacyManager');
  }

  @override
  Future<void> load(SPConfig config) {
    return methodChannel.invokeMethod<String>('load');
  }
}
