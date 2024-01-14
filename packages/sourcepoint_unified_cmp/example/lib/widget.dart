import 'package:flutter/widgets.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';
//import 'package:sourcepoint_unified_cmp_example/controller.dart';

class SourcepointUnifiedCMPBuilder extends FutureBuilder<SPConsent> {
  SourcepointUnifiedCMPBuilder({
    required super.builder,
    required SourcepointController controller,
    super.key,
  }) : super(future: controller.loadMessage());
}
