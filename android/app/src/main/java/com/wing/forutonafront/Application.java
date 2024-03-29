package com.wing.forutonafront;

import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import  io.flutter.plugins.pathprovider.PathProviderPlugin;
import  io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
//        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    }
}

final class FirebaseCloudMessagingPluginRegistrant {

    public static void registerWith(PluginRegistry registry) {
//        if (alreadyRegisteredWith(registry)) {
//            return;
//        }
        FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));

        PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
        SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    }

    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
        final String key = FirebaseCloudMessagingPluginRegistrant.class.getCanonicalName();
        if (registry.hasPlugin(key)) {
            return true;
        }
        registry.registrarFor(key);
        return false;
    }
}