import Flutter
import ConsentViewController
import UIKit

// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

public class SourcepointUnifiedCmpPlugin: UIViewController, FlutterPlugin, SourcepointUnifiedCmpHostApi {
    
    private var consentManager: SPSDK!
    
    func loadMessage(accountId: Int64, propertyId: Int64, propertyName: String, pmId: String, messageLanguage: HostAPIMessageLanguage, campaignsEnv: HostAPICampaignsEnv, messageTimeout: Int64, runGDPRCampaign: Bool, runCCPACampaign: Bool, completion: @escaping (Result<HostAPISPConsent, Error>) -> Void) {
        NSLog(">>>>> WE LOAD MESSAGE")
    consentManager = { SPConsentManager(
        accountId: Int(accountId),
            propertyId: Int(propertyId),
            propertyName: try! SPPropertyName(propertyName),
            campaigns: SPCampaigns(
                gdpr: SPCampaign(),
                ccpa: SPCampaign(),
                ios14: SPCampaign()
            ),
            delegate: self
        )}()
        consentManager.loadMessage()
    }
    
    func loadPrivacyManager(pmId: String, pmTab: HostAPIPMTab, campaignType: HostAPICampaignType, messageType: HostAPIMessageType, completion: @escaping (Result<Void, Error>) -> Void) {
        NSLog(">>>> WE LOAD PRIVACY MANAGER")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : SourcepointUnifiedCmpHostApi & NSObjectProtocol = SourcepointUnifiedCmpPlugin.init()
        SourcepointUnifiedCmpHostApiSetup.setUp(binaryMessenger: messenger, api: api);
        ///registrar.addApplicationDelegate(self)
    }
}

extension SourcepointUnifiedCmpPlugin: SPDelegate {
    func onSPUIReady(_ controller: SPMessageViewController) {
        NSLog("onSPUIReady, sp message view controller")
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
    
    public func onSPUIReady(_ controller: UIViewController) {
        NSLog("onSPUIReady, ui view controller")
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(controller, animated: true)
        }
        //present(controller, animated: true)
        /// UIApplication.shared.keyWindow?.rootViewController?.present(consentManager as! UIViewController, animated: true, completion: nil)
    }

    func onAction(_ action: SPAction, from controller: SPMessageViewController) {
        NSLog("onAction, sp message view controller")
        NSLog("\(action)")
    }
    
    public func onAction(_ action: SPAction, from controller: UIViewController) {
        NSLog("onAction, ui view controller")
        NSLog("\(action)")
    }

    func onSPUIFinished(_ controller: SPMessageViewController) {
        dismiss(animated: true)
    }
    
    
    public func onSPUIFinished(_ controller: UIViewController) {
        NSLog("onSPUIFinished")
    }
    
    public func onSPFinished(userData: SPUserData) {
        NSLog("onSPFinished")
        NSLog("sourcepoint sdk done")
    }

    public func onConsentReady(userData: SPUserData) {
        NSLog("onConsentReady")
        NSLog("onConsentReady:", userData)
        // checking if a gdpr vendor is consented
        userData.gdpr?.consents?.vendorGrants["myVendorId"]?.granted

        // checking if a ccpa vendor is rejected (on ccpa, vendors are accepted by default)
        userData.ccpa?.consents?.rejectedVendors.contains("myVendorId")
    }

    public func onError(error: SPError) {
        NSLog("onError")
        NSLog("Something went wrong: ", error)
    }
    
    public func onSPNativeMessageReady(_ message: SPNativeMessage) {
        NSLog("onSPNativeMessageReady")
    }
}
