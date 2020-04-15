package com.wing.forutonafront;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

import java.util.ArrayList;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.util.ArrayList;

public class MainActivity extends FlutterActivity{


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

    }
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//    }
}