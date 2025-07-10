# Flutter defaults
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Keep annotations
-keepattributes *Annotation*

# Razorpay SDK rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep JSON classes if Razorpay depends on them
-keep class org.json.** { *; }
-dontwarn org.json.**

# Optional: If you see warnings about proguard.annotation.Keep
-keep class proguard.annotation.** { *; }
-dontwarn proguard.annotation.**

# Play Core library
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**

