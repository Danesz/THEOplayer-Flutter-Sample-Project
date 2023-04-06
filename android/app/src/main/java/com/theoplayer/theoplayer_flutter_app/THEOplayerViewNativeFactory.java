package com.theoplayer.theoplayer_flutter_app;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class THEOplayerViewNativeFactory extends PlatformViewFactory {
    /**
     * @param createArgsCodec the codec used to decode the args parameter of {@link #create}.
     */
    public THEOplayerViewNativeFactory(@Nullable MessageCodec<Object> createArgsCodec) {
        super(createArgsCodec);
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        Map<String, Object> creationParams = (Map<String, Object>) args;
        return new THEOplayerViewNative(context, viewId, creationParams);
    }
}
