import 'package:flutter/widgets.dart';
import 'package:sourcepoint_unified_cmp_example/controller.dart';
import 'package:sourcepoint_unified_cmp_example/types.dart';

class SourcepointUnifiedCMPBuilder extends FutureBuilder<SPConsent> {
  SourcepointUnifiedCMPBuilder({
    required super.builder,
    required MockController controller,
    super.key,
  }) : super(future: controller.loadMessage());
}
