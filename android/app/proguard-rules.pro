-keep class com.theoplayer.theoplayer_flutter_app.** { *; }

# Our 3rd party libraries
-keep class androidx.mediarouter.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.ads.interactivemedia.** { *; }
-keep class com.yospace.** { *; }
-keep class com.moat.** { *; }
-keep class tv.agama.** { *; }

# The packages used for testing
-keep class android.test.** { *; }
-keep class androidx.test.** { *; }
-keep class org.apache.** { *; }
-keep class org.junit.** { *; }
-keep class junit.framework.** { *; }
