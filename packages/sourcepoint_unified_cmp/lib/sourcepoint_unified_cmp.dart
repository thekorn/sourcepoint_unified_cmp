// ignore_for_file: public_member_api_docs

import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

export 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart'
    show SPConfig;

SourcepointUnifiedCmpPlatform get _platform =>
    SourcepointUnifiedCmpPlatform.instance;

class SourcepointController {
  SourcepointController({required this.config});
  final SPConfig config;

  /// show privacy manager
  Future<void> loadPrivacyManager() async {
    await _platform.loadPrivacyManager(config);
  }

  /// initially show privacy manager if neccesarry and load consent
  Future<void> load() async {
    await _platform.load(config);
  }

  Future<void> init() async {
    await _platform.init(config);
  }
}
