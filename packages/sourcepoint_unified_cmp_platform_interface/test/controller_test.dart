import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

// Concrete implementation of AbstractSourcepointConsentController for testing.
// It extends AbstractSourcepointConsentController (covering the constructor)
// and mixes in ChangeNotifier to satisfy the ConsentChangeNotifier contract.
class _TestController extends AbstractSourcepointConsentController
    with ChangeNotifier {
  _TestController({required super.config});

  @override
  SPConsent? consent;

  @override
  void updateConsent(SPConsent newConsent) {
    consent = newConsent;
    notifyListeners();
  }

  @override
  void setEventDelegate(SourcepointEventDelegatePlatform delegate) {}

  @override
  Future<void> loadPrivacyManager({
    required String pmId,
    PMTab pmTab = PMTab.purposes,
    CampaignType campaignType = CampaignType.gdpr,
    MessageType messageType = MessageType.mobile,
  }) async {}

  @override
  Future<SPConsent> loadMessage() async => SPConsent();

  @override
  Future<SPConsent> customConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  }) async => SPConsent();

  @override
  Future<SPConsent> deleteCustomConsentGdpr({
    required List<String> vendors,
    required List<String> categories,
    required List<String> legIntCategories,
  }) async => SPConsent();
}

void main() {
  group('AbstractSourcepointConsentController', () {
    late SPConfig config;

    setUp(() {
      config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'test.property',
        pmId: '122058',
        campaigns: [CampaignType.gdpr],
      );
    });

    test('stores config from constructor', () {
      final controller = _TestController(config: config);
      expect(controller.config, config);
      expect(controller.config.accountId, 22);
      expect(controller.config.propertyId, 7639);
      expect(controller.config.pmId, '122058');
    });

    test('loadMessage returns an SPConsent', () async {
      final controller = _TestController(config: config);
      final result = await controller.loadMessage();
      expect(result, isA<SPConsent>());
    });

    test('loadPrivacyManager completes without error', () async {
      final controller = _TestController(config: config);
      await expectLater(
        controller.loadPrivacyManager(pmId: '122058'),
        completes,
      );
    });

    test('updateConsent updates the consent field and notifies listeners', () {
      final controller = _TestController(config: config);
      var notified = false;
      controller.addListener(() => notified = true);

      final consent = SPConsent(webConsents: 'test');
      controller.updateConsent(consent);

      expect(controller.consent, consent);
      expect(notified, isTrue);
    });
  });
}
