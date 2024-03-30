import 'package:flutter/foundation.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// A class that extends [ChangeNotifier] and provides a way to notify listeners
/// when the consent changes.
/// This is triggered by the platform implementation when the consent is ready.
class ConsentChangeNotifier extends ChangeNotifier {
  /// Represents the consent for Sourcepoint Unified CMP.
  SPConsent? consent;

  /// Updates the consent with the provided [newConsent].
  ///
  /// This method is used to update the consent with the new consent information
  /// provided in the [newConsent] parameter.
  /// ```
  void updateConsent(SPConsent newConsent) {
    consent = newConsent;
    notifyListeners();
  }
}
