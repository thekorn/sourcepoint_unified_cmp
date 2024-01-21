import ConsentViewController
import Flutter
import UIKit

// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

public class SourcepointUnifiedCmpPlugin: UIViewController, FlutterPlugin, SourcepointUnifiedCmpHostApi {
    public static var instance: SourcepointUnifiedCmpPlugin?
    private var consentManager: SPSDK!
    private var isInitialized: Completer<SPUserData> = .init()
    private var flutterAPI: SourcepointFlutterApi?

    func loadMessage(accountId: Int64, propertyId: Int64, propertyName: String, pmId _: String, messageLanguage: HostAPIMessageLanguage, campaignsEnv: HostAPICampaignsEnv, messageTimeout: Int64, runGDPRCampaign: Bool, runCCPACampaign: Bool, completion: @escaping (Result<HostAPISPConsent, Error>) -> Void) {
        NSLog(">>>>> WE LOAD MESSAGE")
        consentManager = SPConsentManager(
            accountId: Int(accountId),
            propertyId: Int(propertyId),
            propertyName: try! SPPropertyName(propertyName),
            campaigns: SPCampaigns(
                gdpr: runGDPRCampaign ? SPCampaign() : nil,
                ccpa: runCCPACampaign ? SPCampaign() : nil,
                environment: campaignsEnv.toSPCampaignEnv()
            ),
            delegate: self
        )
        consentManager.messageLanguage = messageLanguage.toSPMessageLanguage()
        consentManager.messageTimeoutInSeconds = Double(messageTimeout) / 1000
        consentManager.loadMessage()
        isInitialized.setCompletionHandler { [completion] result in
            NSLog("Received result: \(result)")
            completion(.success(result.toHostAPISPConsent()))
        }
    }

    func loadPrivacyManager(pmId: String, pmTab: HostAPIPMTab, campaignType: HostAPICampaignType, messageType _: HostAPIMessageType, completion _: @escaping (Result<Void, Error>) -> Void) {
        NSLog(">>>> WE LOAD PRIVACY MANAGER")

        switch campaignType {
        case HostAPICampaignType.gdpr:
            consentManager.loadGDPRPrivacyManager(withId: pmId, tab: pmTab.toSPPrivacyManagerTab())
        case HostAPICampaignType.ccpa:
            consentManager.loadCCPAPrivacyManager(withId: pmId, tab: pmTab.toSPPrivacyManagerTab())
        }
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance = SourcepointUnifiedCmpPlugin()
        instance?.onRegister(registrar)
    }

    public func onRegister(_ registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        SourcepointUnifiedCmpHostApiSetup.setUp(binaryMessenger: messenger, api: self)
        flutterAPI = SourcepointFlutterApi(messenger: messenger)
    }
}

private class SourcepointFlutterApi {
    private var flutterAPI: SourcepointUnifiedCmpFlutterApi

    init(messenger: FlutterBinaryMessenger) {
        flutterAPI = SourcepointUnifiedCmpFlutterApi(binaryMessenger: messenger)
    }

    func callOnConsentReady(userData: SPUserData) {
        flutterAPI.onConsentReady(consent: userData.toHostAPISPConsent()) {
            NSLog("done sending consent to flutter \($0)")
        }
    }

    func callOnUIReady(controller: UIViewController) {
        flutterAPI.onUIReady(viewId: controller.restorationIdentifier ?? "") {
            NSLog("done sending ui ready to flutter \($0)")
        }
    }
    
    func callOnAction(controller: UIViewController, action: SPAction) {
        flutterAPI.onAction(viewId: controller.restorationIdentifier ?? "", consentAction: action.toHostAPIConsentAction()) {
            NSLog("done sendingon action to flutter \($0)")
        }
    }

    func callOnUIFinished(controller: UIViewController) {
        flutterAPI.onUIFinished(viewId: controller.restorationIdentifier ?? "") {
            NSLog("done sending ui finished to flutter \($0)")
        }
    }
    
    func callOnSpFinished(userData: SPUserData) {
        flutterAPI.onSpFinished(consent: userData.toHostAPISPConsent()) {
            NSLog("done sending SP finished to flutter \($0)")
        }
    }
    
    func callOnError(error: SPError) {
        //FIXME: need to map the throwable to the error type
        flutterAPI.onError(error: HostAPISourcepointUnifiedCmpError.invalidArgumentException) {
            NSLog("done sending error to flutter \($0)")
        }
    }
}

extension SourcepointUnifiedCmpPlugin: SPDelegate {
    public func onSPUIReady(_ controller: UIViewController) {
        NSLog("onSPUIReady, ui view controller")
        controller.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            getTopMostViewController()?.present(controller, animated: true)
        }
        flutterAPI?.callOnUIReady(controller: controller)
    }

    public func onAction(_ action: SPAction, from controller: UIViewController) {
        NSLog("onAction, ui view controller")
        NSLog("\(action)")
        flutterAPI?.callOnAction(controller: controller, action: action)
    }

    public func onSPUIFinished(_ controller: UIViewController) {
        NSLog("onSPUIFinished")
        getTopMostViewController()?.dismiss(animated: true)
        flutterAPI?.callOnUIFinished(controller: controller)
    }

    public func onSPFinished(userData: SPUserData) {
        NSLog("onSPFinished")
        flutterAPI?.callOnSpFinished(userData: userData)
        NSLog("sourcepoint sdk done")
    }

    public func onConsentReady(userData: SPUserData) {
        NSLog("onConsentReady")
        isInitialized.complete(result: userData)
        flutterAPI?.callOnConsentReady(userData: userData)
    }

    public func onError(error: SPError) {
        NSLog("onError")
        NSLog("Something went wrong: ", error)
        flutterAPI?.callOnError(error: error)
    }

    public func onSPNativeMessageReady(_: SPNativeMessage) {
        NSLog("onSPNativeMessageReady")
    }
}
