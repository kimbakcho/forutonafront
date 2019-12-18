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

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {

    static final String TAG = "forutonafront";
    static final String CHANNEL = "com.wing.forutonafront/service";

    AppService appService;
    boolean serviceConnected = false;
    MethodChannel.Result keepResult = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(this::onMethodCall);
    }

    private void connectToService() {
        if (!serviceConnected) {
            Intent service = new Intent(this, AppService.class);
            startService(service);
            bindService(service, connection, Context.BIND_AUTO_CREATE);
        } else {
            Log.i(TAG, "Service already connected");
            if (keepResult != null) {
                keepResult.success(null);
                keepResult = null;
            }
        }
    }

    private ServiceConnection connection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName className, IBinder service) {
            AppService.AppServiceBinder binder = (AppService.AppServiceBinder) service;
            appService = binder.getService();
            serviceConnected = true;
            Log.i(TAG, "Service connected");
            if (keepResult != null) {
                keepResult.success(null);
                keepResult = null;
            }
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            serviceConnected = false;
            Log.i(TAG, "Service disconnected");
        }
    };

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        try {
            if (methodCall.method.equals("connectservice")) {
                connectToService();
                keepResult = result;
            } else if (serviceConnected) {
                if (methodCall.method.equals("startLocationManager")) {
                    ArrayList<String> args = (ArrayList<String>) methodCall.arguments;
                    appService.startLocationManager(args.get(0), args.get(1), args.get(2));
                    result.success(null);
                } else if (methodCall.method.equals("stopLocationManager")) {
                    appService.stopLocationManager();
                    result.success(null);
                } else if (methodCall.method.equals("getCurrentSeconds")) {
                    result.success(null);
                } else if (methodCall.method.equals("stopService")) {
                    serviceConnected = false;
                    appService.stopForeground(true);
                }
            }
        } catch (Exception e) {
            result.error(null, e.getMessage(), null);
        }
    }

}