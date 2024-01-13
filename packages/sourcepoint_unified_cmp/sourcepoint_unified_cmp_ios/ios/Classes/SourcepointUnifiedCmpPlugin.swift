import Flutter
import UIKit

public class SourcepointUnifiedCmpPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "sourcepoint_unified_cmp_ios", binaryMessenger: registrar.messenger())
    let instance = SourcepointUnifiedCmpPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS")
  }
}
