//
//  THEOplayerViewNative.swift
//  Runner
//
//  Created by Daniel on 07/04/2023.
//

import Foundation
import THEOplayerSDK

class THEOplayerViewNative: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _theoplayer: THEOplayer
    private var _methodChannel: FlutterMethodChannel


    func view() -> UIView {
        return _view
    }
    
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        _view = UIView()
        _view.frame = frame

        let theoplayer = THEOplayer(configuration: THEOplayerConfiguration(pip: nil))
        theoplayer.frame = _view.bounds
        theoplayer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        theoplayer.addAsSubview(of: self._view)
        
        self._theoplayer = theoplayer
        self._theoplayer.autoplay = true
        

        _methodChannel = FlutterMethodChannel(name: "com.theoplayer/theoplayer-view-native_\(viewId)", binaryMessenger: messenger!)
        
        super.init()

        
        _methodChannel.setMethodCallHandler(self.methodCallHandler)
        
        registerListeners()

    }
    
    //receive messages from dart
    lazy var methodCallHandler: FlutterMethodCallHandler = { call, result in
        switch call.method {
            case "setSource":
                self.setSource(call, result);
                break;
            case "play":
                self.play(call, result);
                break;
            case "pause":
                self.pause(call, result);
                break;
            default:
                break;
        }
    }
    
    func registerListeners() {
        self._theoplayer.addEventListener(type: PlayerEventTypes.TIME_UPDATE) { event in
            // send message to dart
            // method channel invokeMethod with callback (showcase) --- callback can be omitted if the result is not important
            self._methodChannel.invokeMethod("currentTime", arguments: event.currentTime) { result in
                print("Result: ", result)
            }
        }
    }
    
    func setSource(_ call: FlutterMethodCall, _ result: FlutterResult) {
        if let sourceUrl = call.arguments as? String {
            self._theoplayer.source = SourceDescription(source: TypedSource(src: sourceUrl, type: "application/x-mpegurl"))
            result(true)
        } else {
            result(FlutterError(code: "ERROR", message: "Unable to parse sourceUrl", details: nil))
        }

    }
    
    func play(_ call: FlutterMethodCall, _ result: FlutterResult) {
        _theoplayer.play()
        result(_theoplayer.paused)
    }
    
    func pause(_ call: FlutterMethodCall, _ result: FlutterResult) {
        _theoplayer.pause()
        result(_theoplayer.paused)
    }

}
