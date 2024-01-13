import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// The Android implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpAndroid extends SourcepointUnifiedCmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sourcepoint_unified_cmp_android');

  /// Registers this class as the default instance of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
