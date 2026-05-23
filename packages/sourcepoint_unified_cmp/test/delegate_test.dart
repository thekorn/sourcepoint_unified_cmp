import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp/sourcepoint_unified_cmp.dart';

void main() {
  group('SourcepointEventDelegate', () {
    test('creates with all null callbacks by default', () {
      final delegate = SourcepointEventDelegate();
      expect(delegate.onConsentReady, isNull);
      expect(delegate.onUIReady, isNull);
      expect(delegate.onAction, isNull);
      expect(delegate.onError, isNull);
      expect(delegate.onNoIntentActivitiesFound, isNull);
      expect(delegate.onSpFinished, isNull);
      expect(delegate.onUIFinished, isNull);
    });

    test('stores onConsentReady callback', () {
      SPConsent? received;
      final delegate = SourcepointEventDelegate(
        onConsentReady: (consent) => received = consent,
      );

      final consent = SPConsent(webConsents: 'test');
      delegate.onConsentReady?.call(consent);

      expect(received, consent);
    });

    test('stores onUIReady callback', () {
      var called = false;
      final delegate = SourcepointEventDelegate(onUIReady: () => called = true);

      delegate.onUIReady?.call();

      expect(called, isTrue);
    });

    test('stores onUIFinished callback', () {
      var called = false;
      final delegate = SourcepointEventDelegate(
        onUIFinished: () => called = true,
      );

      delegate.onUIFinished?.call();

      expect(called, isTrue);
    });

    test('stores onAction callback', () {
      ConsentAction? received;
      final delegate = SourcepointEventDelegate(
        onAction: (action) => received = action,
      );

      final action = ConsentAction(
        actionType: ActionType.acceptAll,
        pubData: {},
        campaignType: CampaignType.gdpr,
      );
      delegate.onAction?.call(action);

      expect(received, action);
    });

    test('stores onError callback', () {
      SPError? received;
      final delegate = SourcepointEventDelegate(
        onError: (error) => received = error,
      );

      final error = SPError(spCode: 'E001', description: 'An error');
      delegate.onError?.call(error);

      expect(received, error);
    });

    test('stores onNoIntentActivitiesFound callback', () {
      String? received;
      final delegate = SourcepointEventDelegate(
        onNoIntentActivitiesFound: (url) => received = url,
      );

      delegate.onNoIntentActivitiesFound?.call('https://example.com');

      expect(received, 'https://example.com');
    });

    test('stores onSpFinished callback', () {
      SPConsent? received;
      final delegate = SourcepointEventDelegate(
        onSpFinished: (consent) => received = consent,
      );

      final consent = SPConsent(webConsents: 'finished');
      delegate.onSpFinished?.call(consent);

      expect(received, consent);
    });

    test('all callbacks can be set at once', () {
      SPConsent? consentReady;
      ConsentAction? action;
      SPError? error;
      String? url;
      SPConsent? spFinished;
      var uiReady = false;
      var uiFinished = false;

      final delegate = SourcepointEventDelegate(
        onConsentReady: (c) => consentReady = c,
        onUIReady: () => uiReady = true,
        onUIFinished: () => uiFinished = true,
        onAction: (a) => action = a,
        onError: (e) => error = e,
        onNoIntentActivitiesFound: (u) => url = u,
        onSpFinished: (c) => spFinished = c,
      );

      final consent = SPConsent(webConsents: 'test');
      delegate.onConsentReady?.call(consent);
      delegate.onUIReady?.call();
      delegate.onUIFinished?.call();
      delegate.onAction?.call(
        ConsentAction(
          actionType: ActionType.rejectAll,
          pubData: {},
          campaignType: CampaignType.gdpr,
        ),
      );
      delegate.onError?.call(SPError(spCode: 'E001', description: 'err'));
      delegate.onNoIntentActivitiesFound?.call('https://example.com');
      delegate.onSpFinished?.call(SPConsent(webConsents: 'finished'));

      expect(consentReady, consent);
      expect(uiReady, isTrue);
      expect(uiFinished, isTrue);
      expect(action?.actionType, ActionType.rejectAll);
      expect(error?.spCode, 'E001');
      expect(url, 'https://example.com');
      expect(spFinished?.webConsents, 'finished');
    });
  });
}
