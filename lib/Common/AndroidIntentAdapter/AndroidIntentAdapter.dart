import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

abstract class AndroidIntentAdapter {
   createIntent({String data,String action});
   launch();

}
class AndroidIntentAdapterImpl implements AndroidIntentAdapter{

  AndroidIntent _androidIntent;

  createIntent({String data,String action}){
    _androidIntent = AndroidIntent(
      data: data,
      action: action,
    );
  }

  @override
  launch() async{

    await _androidIntent.launch();


  }


}