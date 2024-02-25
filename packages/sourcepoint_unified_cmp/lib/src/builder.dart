import 'package:flutter/widgets.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

/// A builder class for creating a FutureBuilder that returns an SPConsent
/// object.
///
/// This class extends the FutureBuilder class and is used to build a widget
/// that asynchronously retrieves and displays consent information from
/// Sourcepoint Unified CMP. The FutureBuilder is responsible for handling the
/// state of the asynchronous operation  and updating the UI accordingly.
///
/// Example usage:
///
/// ```dart
/// SourcepointUnifiedCMPBuilder(
///   controller: _controller,
///   builder: (BuildContext context, AsyncSnapshot<SPConsent> snapshot) {
///     if (snapshot.hasData) {
///       return Text('Consent: ${snapshot.data}');
///     } else if (snapshot.hasError) {
///       return Text('Error: ${snapshot.error}');
///     } else {
///       return CircularProgressIndicator();
///     }
///   },
/// )
/// ```
class SourcepointUnifiedCMPBuilder extends FutureBuilder<SPConsent> {
  /// A builder class for creating instances of SourcepointUnifiedCMP.
  ///
  /// Use this builder to configure and create instances of
  /// SourcepointUnifiedCMP.  It provides a convenient way to set the
  /// necessary parameters for the CMP.
  SourcepointUnifiedCMPBuilder({
    required super.builder,
    required SourcepointController controller,
    super.key,
  }) : super(future: controller.loadMessage());
}
