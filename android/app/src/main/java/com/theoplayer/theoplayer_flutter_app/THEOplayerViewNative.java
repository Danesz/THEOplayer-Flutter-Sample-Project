package com.theoplayer.theoplayer_flutter_app;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.theoplayer.android.api.THEOplayerConfig;
import com.theoplayer.android.api.THEOplayerGlobal;
import com.theoplayer.android.api.THEOplayerView;
import com.theoplayer.android.api.ads.AdsConfiguration;
import com.theoplayer.android.api.ads.GoogleImaConfiguration;
import com.theoplayer.android.api.event.EventListener;
import com.theoplayer.android.api.event.player.PlayerEventTypes;
import com.theoplayer.android.api.event.player.TimeUpdateEvent;
import com.theoplayer.android.api.source.SourceDescription;
import com.theoplayer.android.api.source.TypedSource;
import com.theoplayer.android.api.source.addescription.GoogleImaAdDescription;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

class THEOplayerViewNative implements PlatformView, MethodChannel.MethodCallHandler {

    final static String TAG = "THEOplayerViewNative";
    final THEOplayerView tpv;
    final MethodChannel methodChannel;

    public THEOplayerViewNative(Context context, int id, Map<String, Object> creationParams, BinaryMessenger messenger) {
        Log.d(TAG, "THEOplayer version: "+ THEOplayerGlobal.getVersion());
        tpv = new THEOplayerView(context, new THEOplayerConfig.Builder().ads(new AdsConfiguration.Builder().googleImaConfiguration(new GoogleImaConfiguration.Builder().useNativeIma(true).build()).build()).build());
        tpv.getPlayer().setAutoplay(true);

        methodChannel = new MethodChannel(messenger, "com.theoplayer/theoplayer-view-native_" + id);
        //receive messages from dart
        methodChannel.setMethodCallHandler(this::onMethodCall);

        registerListeners();

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

    private void registerListeners() {
        tpv.getPlayer().addEventListener(PlayerEventTypes.TIMEUPDATE, new EventListener<TimeUpdateEvent>() {
            @Override
            public void handleEvent(TimeUpdateEvent timeUpdateEvent) {
                // method channel invokeMethod with callback (showcase) --- callback can be omitted if the result is not important
                // send messages to dart
                methodChannel.invokeMethod("currentTime", timeUpdateEvent.getCurrentTime(), new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object result) {
                        Log.d(TAG,"Callback successful: " + result);
                    }

                    @Override
                    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
                        Log.d(TAG, "Callback error: " + errorMessage);
                    }

                    @Override
                    public void notImplemented() {
                        Log.d(TAG,"Callback notImplemented");
                    }
                });
            }
        });
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "setSource":
                setSource(call, result);
                break;
            case "play":
                play(call, result);
                break;
            case "pause":
                pause(call, result);
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
        )
                .ads(
                        new GoogleImaAdDescription.Builder("https://pubads.g.doubleclick.net/gampad/ads?slotname=/124319096/external/ad_rule_samples&sz=640x480&ciu_szs=300x250&cust_params=deployment%3Ddevsite%26sample_ar%3Dpreonly&url=https://developers.google.com/interactive-media-ads/docs/sdks/android/client-side/tags&unviewed_position_start=1&output=xml_vast3&impl=s&env=vp&gdfp_req=1&ad_rule=0&vad_type=linear&vpos=preroll&pod=1&ppos=1&lip=true&min_ad_duration=0&max_ad_duration=30000&vrid=5776&video_doc_id=short_onecue&cmsid=496&kfa=0&tfcd=0")
                                .build()
                )
                .build());
        result.success(true);
    }

    private void play(MethodCall call, MethodChannel.Result result) {
        tpv.getPlayer().play();
        result.success(tpv.getPlayer().isPaused());
    }

    private void pause(MethodCall call, MethodChannel.Result result) {
        tpv.getPlayer().pause();
        result.success(tpv.getPlayer().isPaused());
    }

}