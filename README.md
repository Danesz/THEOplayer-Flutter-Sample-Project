# THEOplayer Flutter Sample Project

This project is a starting point to use THEOplayer Android and iOS SDK in a Flutter project.

The current bindings cover all kinds of interactions with THEOplayer (call a method, register an EventListener, communicate back and forth within Dart and Swift/Java, etc..) as examples that you can base yourself on and implement more if needed.


## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configure THEOplayer licenses

The make THEOplayer play your streams, you need to register on [portal.theoplayer.com](https://portal.theoplayer.com) and generate a license for Android and iOS.

### Android configuration

Put your license key in `android/app/src/main/AndroidManifest.xml` under the `THEOPLAYER_LICENSE ` metadata.

### iOS configuration

Put your license key in `ios/Runner/Info.plist` under the `THEOplayerLicense ` key.

### Testing without a license

THEOplayer is able to play streams hosted on `theoplayer.com` domains without a license. In this case you just need to delete the dummy license entries from the `AndroidManifest.xml` and `Info.plist` files.

For stream URLs you can visit [THEOplayer Demo page](https://www.theoplayer.com/theoplayer-demo-overview)