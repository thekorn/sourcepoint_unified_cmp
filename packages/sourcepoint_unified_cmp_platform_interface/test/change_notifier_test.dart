import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

class _TestConsentChangeNotifier extends ConsentChangeNotifier {}

void main() {
  group('ConsentChangeNotifier', () {
    test('consent is initially null', () {
      final notifier = _TestConsentChangeNotifier();
      expect(notifier.consent, isNull);
    });

    test('updateConsent updates the consent field', () {
      final notifier = _TestConsentChangeNotifier();
      final consent = SPConsent(webConsents: 'test_consent');

      notifier.updateConsent(consent);

      expect(notifier.consent, consent);
    });

    test('updateConsent calls notifyListeners', () {
      final notifier = _TestConsentChangeNotifier();
      var callCount = 0;
      notifier.addListener(() => callCount++);

      notifier.updateConsent(SPConsent(webConsents: 'test_consent'));

      expect(callCount, 1);
    });

    test('updateConsent can be called multiple times', () {
      final notifier = _TestConsentChangeNotifier();
      var callCount = 0;
      notifier.addListener(() => callCount++);

      notifier.updateConsent(SPConsent(webConsents: 'first'));
      notifier.updateConsent(SPConsent(webConsents: 'second'));

      expect(callCount, 2);
      expect(notifier.consent?.webConsents, 'second');
    });

    test('updateConsent notifies multiple listeners', () {
      final notifier = _TestConsentChangeNotifier();
      var firstCount = 0;
      var secondCount = 0;
      notifier
        ..addListener(() => firstCount++)
        ..addListener(() => secondCount++);

      notifier.updateConsent(SPConsent());

      expect(firstCount, 1);
      expect(secondCount, 1);
    });
  });
}
