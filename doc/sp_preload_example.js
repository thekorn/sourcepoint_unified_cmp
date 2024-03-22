const gdprPayload = 
{
  actions: [
  //  {
  //    _id: '65ddc2c607bada060da85296',
  //    type: 'google_consent_mode',
  //    url: '',
  //    js: '',
  //    tagManager: {
  //      _id: '65ddc2c607bada060da85297',
  //      name: 'consent',
  //      key: 'analytics_storage',
  //      value: 'granted'
  //    }
  //  },
  //  {
  //    _id: '65ddc2c607bada060da8529f',
  //    type: 'google_consent_mode',
  //    url: '',
  //    js: '',
  //    tagManager: {
  //      _id: '65ddc2c607bada060da852a0',
  //      name: 'consent',
  //      key: 'ad_storage',
  //      value: 'granted'
  //    }
  //  },
  //  {
  //    _id: '65ddc2c607bada060da852a8',
  //    type: 'google_consent_mode',
  //    url: '',
  //    js: '',
  //    tagManager: {
  //      _id: '65ddc2c607bada060da852a9',
  //      name: 'consent',
  //      key: 'ad_user_data',
  //      value: 'granted'
  //    }
  //  },
  //  {
  //    _id: '65ddc2c607bada060da852b1',
  //    type: 'google_consent_mode',
  //    url: '',
  //    js: '',
  //    tagManager: {
  //      _id: '65ddc2c607bada060da852b2',
  //      name: 'consent',
  //      key: 'ad_personalization',
  //      value: 'granted'
  //    }
  //  }
  ],
  //addtlConsent: '1~899',
  cookies: [],
  consentStatus: {
    rejectedAny: false,
    rejectedLI: false,
    consentedAll: true,
    granularStatus: {
      vendorConsent: 'ALL',
      vendorLegInt: 'ALL',
      purposeConsent: 'ALL',
      purposeLegInt: 'ALL',
      previousOptInAll: false,
      defaultConsent: false
    },
    hasConsentData: true,
    consentedToAny: true
  },
  customVendorsResponse: {
    consentedVendors: [
      {
        _id: '5ff4d000a228633ac048be41',
        name: 'Game Accounts',
        vendorType: 'CUSTOM'
      },
      {
        _id: '5e7e1298b8e05c4854221be9',
        name: 'Google Inc.',
        vendorType: 'CUSTOM'
      },
      {
        _id: '5f1b2fbeb8e05c306f2a1eb9',
        name: 'QuarticON',
        vendorType: 'CUSTOM'
      }
    ],
    consentedPurposes: [
      {
        _id: '608bad95d08d3112188e0e29',
        name: 'Store and/or access information on a device'
      },
      {
        _id: '608bad95d08d3112188e0e2f',
        name: 'Use limited data to select advertising'
      },
      {
        _id: '608bad95d08d3112188e0e36',
        name: 'Create profiles for personalised advertising'
      },
      {
        _id: '608bad95d08d3112188e0e3d',
        name: 'Use profiles to select personalised advertising'
      },
      {
        _id: '608bad96d08d3112188e0e59',
        name: 'Understand audiences through statistics or combinations of data from different sources'
      },
      { _id: '60b65857619abe242bed971e', name: 'Our Custom Purpose' },
      {
        _id: '65c4a19739cd2b04ba0cb49c',
        name: 'GCM Analytics Storage'
      },
      { _id: '65c4a19739cd2b04ba0cb4a6', name: 'GCM Ad Storage' },
      { _id: '65c4a19739cd2b04ba0cb4b0', name: 'GCM Ad User Data' },
      {
        _id: '65c4a19739cd2b04ba0cb4ba',
        name: 'GCM Ad Personalization'
      }
    ],
    legIntPurposes: [
      {
        _id: '608bad95d08d3112188e0e2f',
        name: 'Use limited data to select advertising'
      }
    ]
  },
  dateCreated: '2024-03-03T11:59:11.903Z',
  expirationDate: '2025-03-03T11:59:11.903Z',
  euconsent: 'CP65WcAP65WcAAGABCENAqEsAPCAAEAAAAYgASAAAAAAQAAACBAAIAJBAAEAEg4ACACQoABABIAA.YAAAAAAAAAAA',
  gdprApplies: true,
  grants: {
    '5f1b2fbeb8e05c306f2a1eb9': {
      vendorGrant: true,
      purposeGrants: {
        '608bad95d08d3112188e0e29': true,
        '608bad95d08d3112188e0e2f': true
      }
    },
    '5e7ced57b8e05c485246cce0': {
      vendorGrant: true,
      purposeGrants: {
        '608bad95d08d3112188e0e29': true,
        '608bad95d08d3112188e0e36': true,
        '608bad96d08d3112188e0e59': true,
        '60b65857619abe242bed971e': true
      }
    },
    '5ff4d000a228633ac048be41': {
      vendorGrant: true,
      purposeGrants: {
        '608bad95d08d3112188e0e2f': true,
        '608bad95d08d3112188e0e36': true,
        '608bad95d08d3112188e0e3d': true
      }
    },
    '5e7e1298b8e05c4854221be9': {
      vendorGrant: true,
      purposeGrants: {
        '65c4a19739cd2b04ba0cb49c': true,
        '65c4a19739cd2b04ba0cb4a6': true,
        '65c4a19739cd2b04ba0cb4b0': true,
        '65c4a19739cd2b04ba0cb4ba': true
      }
    }
  },
  vendorListId: '608badf1a22863112f750a18'
}


const consentsJsonObject = {
      "gdpr": {
        "uuid": "9204af52-ec36-42c4-bf56-cd539ad5028c_29",
        "webConsentPayload":JSON.stringify(gdprPayload)
      },
      "ccpa": {
        "uuid": "590ba54f-8063-4d68-a01a-bd3a53a8988c",
        "webConsentPayload":
            "{\"actions\":[],\"cookies\":[{\"key\":\"ccpaConsentAll\",\"value\":true,\"setPath\":true,\"maxAge\":31536000},{\"key\":\"ccpaReject\",\"value\":false,\"setPath\":true,\"maxAge\":31536000},{\"key\":\"consentStatus\",\"value\":\"consentedAll\",\"setPath\":true,\"maxAge\":31536000}],\"consentedAll\":true,\"dateCreated\":\"2024-03-03T11:59:14.694Z\",\"expirationDate\":\"2025-03-03T11:59:14.694Z\",\"rejectedAll\":false,\"rejectedCategories\":[],\"rejectedVendors\":[],\"signedLspa\":false,\"status\":\"consentedAll\"}",
      }}

window.postMessage({
      name: "sp.loadConsent",
      consent: consentsJsonObject
      }, "*")

///"CP65WcAP65WcAAGABCENAqEsAPCAAEAAAAYgASAAAAAAQAAACBAAIAJBAAEAEg4ACACQoABABIAA.YAAAAAAAAAAA"