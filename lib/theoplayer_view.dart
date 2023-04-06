import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

typedef THEOplayerViewCreatedCallback = void Function(THEOplayerViewController controller);

class THEOplayerView extends StatelessWidget {

  final THEOplayerViewCreatedCallback onTHEOplayerViewCreated;

  const THEOplayerView({Key? key, required this.onTHEOplayerViewCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'com.theoplayer/theoplayer-view-native';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};


    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory:
          (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener((id) {
            params.onPlatformViewCreated(id);
            onTHEOplayerViewCreated(THEOplayerViewController._(id));
          })
          ..create();
      },
    );
  }

}

class THEOplayerViewController {
  THEOplayerViewController._(int id) : _channel = MethodChannel('com.theoplayer/theoplayer-view-native_$id');

  final MethodChannel _channel;

  Future<void> setSource({required String sourceURL}) async {
    return _channel.invokeMethod('setSource', sourceURL);
  }
}