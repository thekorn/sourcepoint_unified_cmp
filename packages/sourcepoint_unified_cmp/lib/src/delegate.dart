import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// A delegate class for handling Sourcepoint events.
/// This class implements the SourcepointEventDelegatePlatform interface.
class SourcepointEventDelegate implements SourcepointEventDelegatePlatform {
  /// A delegate class for handling Sourcepoint events.
  SourcepointEventDelegate({
    this.onConsentReady,
    this.onUIReady,
    this.onAction,
    this.onError,
    this.onNoIntentActivitiesFound,
    this.onSpFinished,
    this.onUIFinished,
  });
  @override
  final void Function(SPConsent)? onConsentReady;

  @override
  final void Function(ConsentAction consentAction)? onAction;

  @override
  final void Function(SPError error)? onError;

  @override
  final void Function(String url)? onNoIntentActivitiesFound;

  @override
  final void Function(SPConsent consent)? onSpFinished;

  @override
  final void Function()? onUIFinished;

  @override
  final void Function()? onUIReady;
}
