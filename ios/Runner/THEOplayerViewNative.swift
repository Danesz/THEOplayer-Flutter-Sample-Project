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

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        _view = UIView()

        let theoplayer = THEOplayer(configuration: THEOplayerConfiguration(pip: nil))
        theoplayer.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        theoplayer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        theoplayer.addAsSubview(of: self._view)
        
        self._theoplayer = theoplayer
        self._theoplayer.autoplay = true
        self._theoplayer.source = SourceDescription(source: TypedSource(src: "https://cdn.theoplayer.com/video/big_buck_bunny/big_buck_bunny.m3u8", type: "application/x-mpegurl"))
        super.init()

    }

    func view() -> UIView {
        return _view
    }
    
}
