import UIKit
import Flutter
import THEOplayerSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    print("THEOplayer", THEOplayer.version)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
