package com.theoplayer.theoplayer_flutter_app;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.theoplayer.android.api.THEOplayerConfig;
import com.theoplayer.android.api.THEOplayerView;
import com.theoplayer.android.api.source.SourceDescription;
import com.theoplayer.android.api.source.SourceType;
import com.theoplayer.android.api.source.TypedSource;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

class THEOplayerViewNative implements PlatformView, MethodChannel.MethodCallHandler {

    final THEOplayerView tpv;
    final MethodChannel methodChannel;

    public THEOplayerViewNative(Context context, int id, Map<String, Object> creationParams, BinaryMessenger messenger) {
        tpv = new THEOplayerView(context, new THEOplayerConfig.Builder().build());
        tpv.getPlayer().setAutoplay(true);

        methodChannel = new MethodChannel(messenger, "com.theoplayer/theoplayer-view-native_" + id);
        methodChannel.setMethodCallHandler(this::onMethodCall);

    }

    @Nullable
    @Override
    public View getView() {
        return tpv;
    }

    @Override
    public void dispose() {
        tpv.onDestroy();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "setSource":
                setSource(call, result);
                break;
            default:
                break;
        }
    }

    private void setSource(MethodCall call, MethodChannel.Result result) {
        String sourceUrl = (String) call.arguments;
        tpv.getPlayer().setSource(new SourceDescription.Builder(
                new TypedSource.Builder(sourceUrl)
                        .build()
        ).build());
        result.success(null);
    }

    // set and load new Url
}