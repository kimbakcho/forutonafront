#Flutter Location Plugin

This plugin for Flutter handles getting location on Android and iOS. It also provides callbacks when location is changed.

Add this to your package's pubspec.yaml file:

````
dependencies:
  location:
````
2. Install it
You can install packages from the command line:

with Flutter:

````
$ flutter pub get
````

Update your gradle.properties file with this:
````
android.enableJetifier=true
android.useAndroidX=true
org.gradle.jvmargs=-Xmx1536M
````
Please also make sure that you have those dependencies in your build.gradle:
````
  dependencies {
      classpath 'com.android.tools.build:gradle:3.3.0'
      classpath 'com.google.gms:google-services:4.2.0'
  }
...
  compileSdkVersion 28
````
###Android
In order to use this plugin in Android, you have to add this permission in AndroidManifest.xml :
````
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
````
Permission check for Android 6+ was added.
###iOS
And to use it in iOS, you have to add this permission in Info.plist :
````
NSLocationWhenInUseUsageDescription
NSLocationAlwaysUsageDescription
````
Warning: there is a currently a bug in iOS simulator in which you have to manually select a Location several in order for the Simulator to actually send data. Please keep that in mind when testing in iOS simulator.

###Example App
The example app uses Google Maps Flutter Plugin, add your API Key in the AndroidManifest.xml and in AppDelegate.m to use the Google Maps plugin.
