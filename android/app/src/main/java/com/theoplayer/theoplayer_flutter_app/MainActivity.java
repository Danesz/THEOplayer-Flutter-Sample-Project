package com.theoplayer.theoplayer_flutter_app;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.StandardMessageCodec;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        flutterEngine.getPlatformViewsController().getRegistry().registerViewFactory("theoplayer-view-native", new THEOplayerViewNativeFactory(StandardMessageCodec.INSTANCE));

        super.configureFlutterEngine(flutterEngine);
    }
}
