import Flutter
import UIKit

public class SwiftWebviewCookieManagerWebPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "webview_cookie_manager_web", binaryMessenger: registrar.messenger())
    let instance = SwiftWebviewCookieManagerWebPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
