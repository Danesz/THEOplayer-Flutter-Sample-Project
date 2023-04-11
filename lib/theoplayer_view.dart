import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:theoplayer_flutter_app/theoplayer_view_controller.dart';

typedef THEOplayerViewCreatedCallback = void Function(THEOplayerViewController controller);

class THEOplayerView extends StatelessWidget {

  static const String TAG = "THEOplayerView";

  final THEOplayerViewCreatedCallback onTHEOplayerViewCreated;

  const THEOplayerView({Key? key, required this.onTHEOplayerViewCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'com.theoplayer/theoplayer-view-native';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
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
            // https://github.com/flutter/flutter/issues/103630
            return PlatformViewsService.initExpensiveAndroidView(
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
                onTHEOplayerViewCreated(THEOplayerViewController(id));
              })
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: (id) {
              onTHEOplayerViewCreated(THEOplayerViewController(id));
            }
        );
      default:
        return Text("Unsupported platform $defaultTargetPlatform");
    }


  }

}
