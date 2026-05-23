import 'package:flutter_test/flutter_test.dart';
import 'package:sourcepoint_unified_cmp_platform_interface/sourcepoint_unified_cmp_platform_interface.dart';

void main() {
  group('SPConfig', () {
    test('creates with required parameters using defaults', () {
      final config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'test.property',
        pmId: '123',
        campaigns: [CampaignType.gdpr],
      );
      expect(config.accountId, 22);
      expect(config.propertyId, 7639);
      expect(config.propertyName, 'test.property');
      expect(config.pmId, '123');
      expect(config.campaigns, [CampaignType.gdpr]);
      expect(config.messageLanguage, MessageLanguage.english);
      expect(config.campaignsEnv, CampaignsEnv.public);
      expect(config.messageTimeout, 30000);
    });

    test('creates with optional parameters overriding defaults', () {
      final config = SPConfig(
        accountId: 22,
        propertyId: 7639,
        propertyName: 'test.property',
        pmId: '123',
        campaigns: [CampaignType.gdpr, CampaignType.ccpa],
        messageLanguage: MessageLanguage.german,
        campaignsEnv: CampaignsEnv.stage,
        messageTimeout: 10000,
      );
      expect(config.messageLanguage, MessageLanguage.german);
      expect(config.campaignsEnv, CampaignsEnv.stage);
      expect(config.messageTimeout, 10000);
      expect(config.campaigns, contains(CampaignType.ccpa));
    });
  });

  group('GDPRPurposeGrants', () {
    test('creates with required parameters', () {
      final grants = GDPRPurposeGrants(
        granted: true,
        purposeGrants: {'purpose1': true, 'purpose2': false},
      );
      expect(grants.granted, isTrue);
      expect(grants.purposeGrants, {'purpose1': true, 'purpose2': false});
    });

    test('toString contains key fields', () {
      final grants = GDPRPurposeGrants(
        granted: true,
        purposeGrants: {'purpose1': true},
      );
      expect(grants.toString(), contains('GDPRPurposeGrants'));
      expect(grants.toString(), contains('granted: true'));
      expect(grants.toString(), contains('purpose1'));
    });
  });

  group('GranularStatus', () {
    test('creates with all null fields', () {
      final status = GranularStatus();
      expect(status.defaultConsent, isNull);
      expect(status.previousOptInAll, isNull);
      expect(status.purposeConsent, isNull);
      expect(status.purposeLegInt, isNull);
      expect(status.vendorConsent, isNull);
      expect(status.vendorLegInt, isNull);
    });

    test('toString contains GranularStatus', () {
      final status = GranularStatus();
      expect(status.toString(), contains('GranularStatus'));
    });

    test('creates with all fields populated', () {
      final status = GranularStatus(
        defaultConsent: true,
        previousOptInAll: false,
        purposeConsent: GranularState.all,
        purposeLegInt: GranularState.some,
        vendorConsent: GranularState.none,
        vendorLegInt: GranularState.emptyVl,
      );
      expect(status.defaultConsent, isTrue);
      expect(status.previousOptInAll, isFalse);
      expect(status.purposeConsent, GranularState.all);
      expect(status.purposeLegInt, GranularState.some);
      expect(status.vendorConsent, GranularState.none);
      expect(status.vendorLegInt, GranularState.emptyVl);
    });

    test('toString with all fields contains expected values', () {
      final status = GranularStatus(
        defaultConsent: true,
        previousOptInAll: false,
        purposeConsent: GranularState.all,
      );
      expect(status.toString(), contains('defaultConsent: true'));
      expect(status.toString(), contains('previousOptInAll: false'));
    });
  });

  group('ConsentStatus', () {
    test('creates with all null fields', () {
      final status = ConsentStatus();
      expect(status.consentedAll, isNull);
      expect(status.consentedToAny, isNull);
      expect(status.granularStatus, isNull);
      expect(status.hasConsentData, isNull);
      expect(status.rejectedAny, isNull);
      expect(status.rejectedLI, isNull);
      expect(status.legalBasisChanges, isNull);
      expect(status.vendorListAdditions, isNull);
    });

    test('toString contains ConsentStatus', () {
      final status = ConsentStatus();
      expect(status.toString(), contains('ConsentStatus'));
    });

    test('creates with all fields populated', () {
      final granularStatus = GranularStatus(defaultConsent: true);
      final status = ConsentStatus(
        consentedAll: true,
        consentedToAny: true,
        granularStatus: granularStatus,
        hasConsentData: true,
        rejectedAny: false,
        rejectedLI: false,
        legalBasisChanges: false,
        vendorListAdditions: false,
      );
      expect(status.consentedAll, isTrue);
      expect(status.consentedToAny, isTrue);
      expect(status.granularStatus, granularStatus);
      expect(status.hasConsentData, isTrue);
      expect(status.rejectedAny, isFalse);
    });

    test('toString with all fields contains expected values', () {
      final status = ConsentStatus(
        consentedAll: true,
        consentedToAny: false,
        hasConsentData: true,
        rejectedAny: false,
        rejectedLI: true,
        legalBasisChanges: false,
        vendorListAdditions: true,
      );
      expect(status.toString(), contains('consentedAll: true'));
      expect(status.toString(), contains('consentedToAny: false'));
      expect(status.toString(), contains('hasConsentData: true'));
      expect(status.toString(), contains('rejectedLI: true'));
    });
  });

  group('GDPRConsent', () {
    test('creates with required parameters', () {
      final consent = GDPRConsent(
        tcData: {'key': 'value'},
        grants: {},
        euconsent: 'euconsent_string',
        acceptedCategories: ['cat1'],
        apply: true,
      );
      expect(consent.uuid, isNull);
      expect(consent.consentStatus, isNull);
      expect(consent.euconsent, 'euconsent_string');
      expect(consent.apply, isTrue);
      expect(consent.tcData, {'key': 'value'});
      expect(consent.acceptedCategories, ['cat1']);
    });

    test('creates with all optional parameters', () {
      final consentStatus = ConsentStatus(consentedAll: true);
      final grants = {
        'vendor1': GDPRPurposeGrants(
          granted: true,
          purposeGrants: {'p1': true},
        ),
      };
      final consent = GDPRConsent(
        tcData: {'TC': 'data'},
        grants: grants,
        euconsent: 'consent_string',
        acceptedCategories: ['cat1', 'cat2'],
        apply: false,
        uuid: 'test-uuid',
        consentStatus: consentStatus,
      );
      expect(consent.uuid, 'test-uuid');
      expect(consent.consentStatus, consentStatus);
      expect(consent.grants, grants);
    });

    test('toString contains key fields', () {
      final consent = GDPRConsent(
        tcData: {},
        grants: {},
        euconsent: 'consent_string',
        acceptedCategories: [],
        apply: true,
        uuid: 'test-uuid',
      );
      expect(consent.toString(), contains('GDPRConsent'));
      expect(consent.toString(), contains('consent_string'));
      expect(consent.toString(), contains('test-uuid'));
    });
  });

  group('CCPAConsent', () {
    test('creates with required parameters', () {
      final consent = CCPAConsent(
        rejectedCategories: ['cat1'],
        rejectedVendors: ['vendor1'],
        uspstring: '1YNN',
        apply: true,
      );
      expect(consent.rejectedCategories, ['cat1']);
      expect(consent.rejectedVendors, ['vendor1']);
      expect(consent.uspstring, '1YNN');
      expect(consent.apply, isTrue);
      expect(consent.uuid, isNull);
      expect(consent.status, isNull);
    });

    test('creates with optional parameters', () {
      final consent = CCPAConsent(
        rejectedCategories: [],
        rejectedVendors: [],
        uspstring: '1---',
        apply: false,
        uuid: 'uuid-123',
        status: 'consentedAll',
      );
      expect(consent.uuid, 'uuid-123');
      expect(consent.status, 'consentedAll');
      expect(consent.apply, isFalse);
    });
  });

  group('SPConsent', () {
    test('creates with all null fields', () {
      final consent = SPConsent();
      expect(consent.gdpr, isNull);
      expect(consent.ccpa, isNull);
      expect(consent.webConsents, isNull);
    });

    test('toString contains SPConsent', () {
      final consent = SPConsent();
      expect(consent.toString(), contains('SPConsent'));
    });

    test('creates with gdpr consent', () {
      final gdpr = GDPRConsent(
        tcData: {},
        grants: {},
        euconsent: '',
        acceptedCategories: [],
        apply: true,
      );
      final consent = SPConsent(gdpr: gdpr);
      expect(consent.gdpr, gdpr);
    });

    test('creates with ccpa consent', () {
      final ccpa = CCPAConsent(
        rejectedCategories: [],
        rejectedVendors: [],
        uspstring: '1YNN',
        apply: true,
      );
      final consent = SPConsent(ccpa: ccpa);
      expect(consent.ccpa, ccpa);
    });

    test('creates with webConsents and toString works', () {
      final consent = SPConsent(webConsents: 'web_consent_string');
      expect(consent.webConsents, 'web_consent_string');
      expect(consent.toString(), contains('web_consent_string'));
    });
  });

  group('ConsentAction', () {
    test('creates with required parameters', () {
      final action = ConsentAction(
        actionType: ActionType.acceptAll,
        pubData: <String, Object?>{},
        campaignType: CampaignType.gdpr,
      );
      expect(action.actionType, ActionType.acceptAll);
      expect(action.campaignType, CampaignType.gdpr);
      expect(action.pubData, <String, Object?>{});
      expect(action.customActionId, isNull);
    });

    test('creates with optional customActionId', () {
      final action = ConsentAction(
        actionType: ActionType.custom,
        pubData: {'key': 'value'},
        campaignType: CampaignType.ccpa,
        customActionId: 'my-custom-action',
      );
      expect(action.customActionId, 'my-custom-action');
      expect(action.pubData, {'key': 'value'});
    });
  });

  group('SPError', () {
    test('creates with required parameters', () {
      final error = SPError(spCode: 'E_001', description: 'An error occurred');
      expect(error.spCode, 'E_001');
      expect(error.description, 'An error occurred');
    });

    test('toString contains key fields', () {
      final error = SPError(spCode: 'E_001', description: 'An error occurred');
      expect(error.toString(), contains('SPError'));
      expect(error.toString(), contains('E_001'));
      expect(error.toString(), contains('An error occurred'));
    });
  });

  group('MessageLanguage enum', () {
    test('has all expected values', () {
      expect(MessageLanguage.values.length, 6);
      expect(MessageLanguage.values, contains(MessageLanguage.english));
      expect(MessageLanguage.values, contains(MessageLanguage.french));
      expect(MessageLanguage.values, contains(MessageLanguage.german));
      expect(MessageLanguage.values, contains(MessageLanguage.italian));
      expect(MessageLanguage.values, contains(MessageLanguage.spanish));
      expect(MessageLanguage.values, contains(MessageLanguage.dutch));
    });
  });

  group('CampaignsEnv enum', () {
    test('has all expected values', () {
      expect(CampaignsEnv.values, contains(CampaignsEnv.stage));
      expect(CampaignsEnv.values, contains(CampaignsEnv.public));
    });
  });

  group('PMTab enum', () {
    test('has all expected values', () {
      expect(PMTab.values, contains(PMTab.purposes));
      expect(PMTab.values, contains(PMTab.defaults));
      expect(PMTab.values, contains(PMTab.vendors));
      expect(PMTab.values, contains(PMTab.features));
    });
  });

  group('CampaignType enum', () {
    test('has all expected values', () {
      expect(CampaignType.values.length, 7);
      expect(CampaignType.values, contains(CampaignType.gdpr));
      expect(CampaignType.values, contains(CampaignType.ccpa));
      expect(CampaignType.values, contains(CampaignType.usnat));
      expect(CampaignType.values, contains(CampaignType.ios14));
      expect(CampaignType.values, contains(CampaignType.globalcmp));
      expect(CampaignType.values, contains(CampaignType.preferences));
      expect(CampaignType.values, contains(CampaignType.unknown));
    });
  });

  group('MessageType enum', () {
    test('has all expected values', () {
      expect(MessageType.values, contains(MessageType.mobile));
      expect(MessageType.values, contains(MessageType.ott));
      expect(MessageType.values, contains(MessageType.legacyOtt));
    });
  });

  group('GranularState enum', () {
    test('has all expected values', () {
      expect(GranularState.values, contains(GranularState.all));
      expect(GranularState.values, contains(GranularState.some));
      expect(GranularState.values, contains(GranularState.none));
      expect(GranularState.values, contains(GranularState.emptyVl));
    });
  });

  group('ActionType enum', () {
    test('has all expected values', () {
      expect(ActionType.values, contains(ActionType.showOptions));
      expect(ActionType.values, contains(ActionType.rejectAll));
      expect(ActionType.values, contains(ActionType.acceptAll));
      expect(ActionType.values, contains(ActionType.msgCancel));
      expect(ActionType.values, contains(ActionType.custom));
      expect(ActionType.values, contains(ActionType.saveAndExit));
      expect(ActionType.values, contains(ActionType.pmDismiss));
      expect(ActionType.values, contains(ActionType.getMsgError));
      expect(ActionType.values, contains(ActionType.getMessageNotCalled));
      expect(ActionType.values, contains(ActionType.unknown));
    });
  });
}
