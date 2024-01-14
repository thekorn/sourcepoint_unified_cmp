import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel_sourcepoint_unified_cmp.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

export 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

/// The interface that implementations of sourcepoint_unified_cmp must
/// implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `SourcepointUnifiedCmp`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added
/// [SourcepointUnifiedCmpPlatform] methods.
abstract class SourcepointUnifiedCmpPlatform extends PlatformInterface {
  /// Constructs a SourcepointUnifiedCmpPlatform.
  SourcepointUnifiedCmpPlatform() : super(token: _token);

  static final Object _token = Object();

  static SourcepointUnifiedCmpPlatform _instance =
      MethodChannelSourcepointUnifiedCmp();

  /// The default instance of [SourcepointUnifiedCmpPlatform] to use.
  ///
  /// Defaults to [MethodChannelSourcepointUnifiedCmp].
  static SourcepointUnifiedCmpPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SourcepointUnifiedCmpPlatform] when they register
  /// themselves.
  static set instance(SourcepointUnifiedCmpPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// show privacy manager
  Future<void> loadMessage(SPConfig config) {
    throw UnimplementedError('loadMessage() has not been implemented.');
  }
}
