import ConsentViewController
import Flutter
import UIKit


// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

public class SourcepointUnifiedCmpPlugin: UIViewController, FlutterPlugin, SourcepointUnifiedCmpHostApi {
    private var consentManager: SPSDK!
    private var isInitialized: Completer<SPUserData> = .init()

    func loadMessage(accountId: Int64, propertyId: Int64, propertyName: String, pmId _: String, messageLanguage _: HostAPIMessageLanguage, campaignsEnv _: HostAPICampaignsEnv, messageTimeout _: Int64, runGDPRCampaign _: Bool, runCCPACampaign _: Bool, completion: @escaping (Result<HostAPISPConsent, Error>) -> Void) {
        NSLog(">>>>> WE LOAD MESSAGE")
        consentManager = SPConsentManager(
            accountId: Int(accountId),
            propertyId: Int(propertyId),
            propertyName: try! SPPropertyName(propertyName),
            campaigns: SPCampaigns(
                gdpr: SPCampaign(),
                ccpa: SPCampaign(),
                ios14: SPCampaign()
            ),
            delegate: self
        )
        consentManager.loadMessage()
        isInitialized.setCompletionHandler { [completion] result in
            NSLog("Received result: \(result)")
            completion(.success(result.toHostAPISPConsent()))
        }
    }

    func loadPrivacyManager(pmId _: String, pmTab _: HostAPIPMTab, campaignType _: HostAPICampaignType, messageType _: HostAPIMessageType, completion _: @escaping (Result<Void, Error>) -> Void) {
        NSLog(">>>> WE LOAD PRIVACY MANAGER")
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let api: SourcepointUnifiedCmpHostApi & NSObjectProtocol = SourcepointUnifiedCmpPlugin()
        SourcepointUnifiedCmpHostApiSetup.setUp(binaryMessenger: messenger, api: api)
    }
}

extension SourcepointUnifiedCmpPlugin: SPDelegate {
    public func onSPUIReady(_ controller: UIViewController) {
        NSLog("onSPUIReady, ui view controller")
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            getTopMostViewController()?.present(controller, animated: true)
        }
    }

    func onAction(_ action: SPAction, from _: SPMessageViewController) {
        NSLog("onAction, sp message view controller")
        NSLog("\(action)")
    }

    public func onAction(_ action: SPAction, from _: UIViewController) {
        NSLog("onAction, ui view controller")
        NSLog("\(action)")
    }

    public func onSPUIFinished(_: UIViewController) {
        NSLog("onSPUIFinished")
        getTopMostViewController()?.dismiss(animated: true)
    }

    public func onSPFinished(userData _: SPUserData) {
        NSLog("onSPFinished")
        NSLog("sourcepoint sdk done")
    }

    public func onConsentReady(userData: SPUserData) {
        NSLog("onConsentReady")
        NSLog("onConsentReady: \(userData)")
        isInitialized.complete(result: userData)
    }

    public func onError(error: SPError) {
        NSLog("onError")
        NSLog("Something went wrong: ", error)
    }

    public func onSPNativeMessageReady(_: SPNativeMessage) {
        NSLog("onSPNativeMessageReady")
    }
}
