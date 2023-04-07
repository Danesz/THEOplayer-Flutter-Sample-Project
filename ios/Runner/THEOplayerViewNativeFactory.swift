//
//  THEOplayerViewNativeFactory.swift
//  Runner
//
//  Created by Daniel on 07/04/2023.
//

import Foundation

class THEOplayerNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return THEOplayerViewNative(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
}
