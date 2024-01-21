import Flutter
import UIKit

// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

public class SourcepointUnifiedCmpPlugin: NSObject, FlutterPlugin, SourcepointUnifiedCmpHostApi {
    func loadMessage(accountId: Int64, propertyId: Int64, propertyName: String, pmId: String, messageLanguage: HostAPIMessageLanguage, campaignsEnv: HostAPICampaignsEnv, messageTimeout: Int64, runGDPRCampaign: Bool, runCCPACampaign: Bool, completion: @escaping (Result<HostAPISPConsent, Error>) -> Void) {
        NSLog(">>>>> WE LOAD MESSAGE")
    }
    
    func loadPrivacyManager(pmId: String, pmTab: HostAPIPMTab, campaignType: HostAPICampaignType, messageType: HostAPIMessageType, completion: @escaping (Result<Void, Error>) -> Void) {
        NSLog(">>>> WE LOAD PRIVACY MANAGER")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
            let api : SourcepointUnifiedCmpHostApi & NSObjectProtocol = SourcepointUnifiedCmpPlugin.init()
        SourcepointUnifiedCmpHostApiSetup.setUp(binaryMessenger: messenger, api: api);
    }
}
