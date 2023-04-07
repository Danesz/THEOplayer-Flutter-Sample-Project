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
      
    weak var registrar = self.registrar(forPlugin: "com.theoplayer.theoplayer-view-native")

    let factory = THEOplayerNativeViewFactory(messenger: registrar!.messenger())
    registrar?.register(factory, withId: "com.theoplayer/theoplayer-view-native")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
