import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

/// An abstract class representing a Sourcepoint consent controller.
///
/// This class serves as the base class for all Sourcepoint consent controllers.
/// It provides common functionality and defines the contract that concrete
/// implementations must adhere to.
abstract class AbstractSourcepointConsentController
    implements ConsentChangeNotifier {
  /// Creates a new instance of the [AbstractSourcepointConsentController]
  /// class.
  AbstractSourcepointConsentController({required this.config});

  /// The configuration for the Sourcepoint consent management platform.
  final SPConfig config;

  /// Registers the [delegate] as the event delegate for the Sourcepoint
  void setEventDelegate(SourcepointEventDelegatePlatform delegate);

  /// Loading a Privacy Manager on demand
  /// consent changes will propagated via controller
  Future<void> loadPrivacyManager({
    required String pmId,
    PMTab pmTab = PMTab.purposes,
    CampaignType campaignType = CampaignType.gdpr,
    MessageType messageType = MessageType.mobile,
  });

  /// Loading the First Layer Message
  /// and returns the initial consent status
  Future<SPConsent> loadMessage();

  /// Programmatically grant custom GDPR consent to the supplied [vendors],
  /// [categories] and [legIntCategories].
  ///
  /// Returns the updated [SPConsent] reflecting the new consent state.
  Future<SPConsent> customConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  });

  /// Programmatically delete custom GDPR consent for the supplied [vendors],
  /// [categories] and [legIntCategories].
  ///
  /// Returns the updated [SPConsent] reflecting the new consent state.
  Future<SPConsent> deleteCustomConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  });
}
