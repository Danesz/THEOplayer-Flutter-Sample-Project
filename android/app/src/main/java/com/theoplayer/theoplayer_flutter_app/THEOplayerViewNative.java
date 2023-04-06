package com.theoplayer.theoplayer_flutter_app;

import android.content.Context;
import android.view.View;

import androidx.annotation.Nullable;

import com.theoplayer.android.api.THEOplayerConfig;
import com.theoplayer.android.api.THEOplayerView;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

class THEOplayerViewNative implements PlatformView {

    THEOplayerView tpv;

    public THEOplayerViewNative(Context context, int id, Map<String, Object> creationParams) {
        tpv = new THEOplayerView(context, new THEOplayerConfig.Builder().build());
    }

    @Nullable
    @Override
    public View getView() {
        return tpv;
    }

    @Override
    public void dispose() {

    }
}