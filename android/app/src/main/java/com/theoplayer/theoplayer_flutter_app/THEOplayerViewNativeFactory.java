package com.theoplayer.theoplayer_flutter_app;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class THEOplayerViewNativeFactory extends PlatformViewFactory {

    final BinaryMessenger messenger;
    public THEOplayerViewNativeFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        Map<String, Object> creationParams = (Map<String, Object>) args;
        return new THEOplayerViewNative(context, viewId, creationParams, messenger);
    }
}
