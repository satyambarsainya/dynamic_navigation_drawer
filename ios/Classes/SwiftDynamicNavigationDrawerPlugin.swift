import Flutter
import UIKit

public class SwiftDynamicNavigationDrawerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dynamic_navigation_drawer", binaryMessenger: registrar.messenger())
    let instance = SwiftDynamicNavigationDrawerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
