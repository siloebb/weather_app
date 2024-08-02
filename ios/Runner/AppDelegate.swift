import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "com.example.app/weather_app", binaryMessenger: controller.binaryMessenger)

      channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "getPlatformVersion" {
          result("iOS " + UIDevice.current.systemVersion)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
