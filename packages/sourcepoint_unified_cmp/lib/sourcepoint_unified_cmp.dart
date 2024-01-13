import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

/// show privacy manager
Future<void> loadPrivacyManager() async {
  await _platform.loadPrivacyManager();
}
