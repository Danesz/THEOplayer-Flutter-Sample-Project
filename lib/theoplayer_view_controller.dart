import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:theoplayer_flutter_app/theoplayer_eventlisteners.dart';

class THEOplayerViewController {

  static const String TAG = "THEOplayerViewController";

  late final MethodChannel _channel;
  bool _isPaused = true;
  Map<String, List<EventListener<Event>>> _eventListenerMap = HashMap();

  THEOplayerViewController(int id) {
    _channel = MethodChannel('com.theoplayer/theoplayer-view-native_$id');
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'currentTime':
        dynamic text = call.arguments;
        print("${THEOplayerViewController.TAG}  currentTime received: $text");
        dispatchEvent(CurrentTimeEvent(currentTime :text as double));
        return Future.value();
    }
  }

  // add eventListeners
  void addEventListener(String eventType, EventListener<Event> listener) {
    if (_eventListenerMap.containsKey(eventType) && _eventListenerMap[eventType] != null) {
      _eventListenerMap[eventType]!.add(listener);
    } else {
      _eventListenerMap[eventType] = [];
      _eventListenerMap[eventType]!.add(listener);
    }
  }

  void dispatchEvent(Event event) {
    _eventListenerMap[event.type]?.forEach((element) {
      element(event);
    });
  }

  //invoke methods in native
  Future<void> setSource({required String sourceURL}) async {
    bool retval = await _channel.invokeMethod('setSource', sourceURL) as bool;
    print("${THEOplayerViewController.TAG} setSource successful: $retval");
  }

  Future<void> pause() async {
    bool retval = await _channel.invokeMethod('pause');
    _isPaused = retval;
  }

  Future<void> play() async {
    bool retval = await _channel.invokeMethod('play');
    _isPaused = retval;
  }

  //local state getters
  bool isPaused() {
    return _isPaused;
  }
}