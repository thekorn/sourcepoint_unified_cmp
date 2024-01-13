import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// The iOS implementation of [SourcepointUnifiedCmpPlatform].
class SourcepointUnifiedCmpIOS extends SourcepointUnifiedCmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sourcepoint_unified_cmp_ios');

  /// Registers this class as the default instance of [SourcepointUnifiedCmpPlatform]
  static void registerWith() {
    SourcepointUnifiedCmpPlatform.instance = SourcepointUnifiedCmpIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
