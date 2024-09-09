import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/change_notifier.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/method_channel.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/src/types.dart';

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

  @visibleForTesting
  // ignore: public_member_api_docs, use_setters_to_change_properties
  static void setInstanceUnverified(SourcepointUnifiedCmpPlatform instance) {
    _instance = instance;
  }

  /// Registers the [delegate] as the event delegate for the Sourcepoint
  /// Unified CMP platform interface.
  ///
  /// The [delegate] will receive events and notifications from the
  /// Sourcepoint Unified CMP platform.
  /// Use this method to set a custom delegate that handles events and
  /// notifications according to your application's needs.
  ///
  /// Example usage:
  /// ```dart
  /// SourcepointEventDelegatePlatform delegate = MyEventDelegate();
  /// registerEventDelegate(delegate);
  /// ```
  void registerEventDelegate(SourcepointEventDelegatePlatform delegate) {
    throw UnimplementedError(
      'registerEventDelegate() has not been implemented.',
    );
  }

  /// Registers a [ConsentChangeNotifier] to receive notifications when the
  /// consent changes.
  ///
  /// The [notifier] parameter is the [ConsentChangeNotifier] instance that
  /// will be registered. When the consent changes, the
  /// [ConsentChangeNotifier]'s listeners will be notified.
  void registerConsentChangeNotifier(ConsentChangeNotifier notifier) {
    throw UnimplementedError(
      'registerConsentChangeNotifier() has not been implemented.',
    );
  }

  /// show privacy manager
  Future<SPConsent> loadMessage(SPConfig config) {
    throw UnimplementedError('loadMessage() has not been implemented.');
  }

  /// Loading a Privacy Manager on demand
  Future<void> loadPrivacyManager(
    String pmId,
    PMTab pmTab,
    CampaignType campaignType,
    MessageType messageType,
  ) {
    throw UnimplementedError('loadPrivacyManager() has not been implemented.');
  }
}

/// Represents the platform interface for handling Sourcepoint event delegates.
/// This abstract class defines the contract for implementing Sourcepoint event
/// delegates on different platforms.
abstract class SourcepointEventDelegatePlatform {
  /// Represents a platform-specific delegate for handling Sourcepoint events.
  /// This delegate is responsible for handling events related to the
  /// Sourcepoint Unified CMP platform interface.
  SourcepointEventDelegatePlatform({
    this.onConsentReady,
    this.onUIFinished,
    this.onUIReady,
    this.onError,
    this.onAction,
    this.onNoIntentActivitiesFound,
    this.onSpFinished,
  });

  /// A callback function that is called when the consent is ready.
  ///
  /// The [onConsentReady] function takes a single parameter of
  /// type [SPConsent],
  /// which represents the consent information.
  final void Function(SPConsent)? onConsentReady;

  /// Callback function that is called when the UI is finished.
  final void Function()? onUIFinished;

  /// Callback function that is called when the UI is ready.
  final void Function()? onUIReady;

  /// Callback function that is called when an error occurs.
  final void Function(SPError error)? onError;

  /// Callback function that is called when an action occurs.
  final void Function(ConsentAction consentAction)? onAction;

  /// Callback function that is called when no intent activities are found.
  final void Function(String url)? onNoIntentActivitiesFound;

  /// Callback function that is called when the Sourcepoint Unified CMP
  final void Function(SPConsent consent)? onSpFinished;
}
