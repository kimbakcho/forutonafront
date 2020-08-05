import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

abstract class AndroidIntentAdapter {
   static int FLAG_ACTIVITY_NEW_TASK = 0x10000000;
   createIntent({String data,String action,String package,List<int> flags});
   launch();

}
class AndroidIntentAdapterImpl implements AndroidIntentAdapter{

  AndroidIntent _androidIntent;

  createIntent({String data,String action,String package,List<int> flags}){
    _androidIntent = AndroidIntent(
      data: data,
      action: action,
      package: package,
      flags: flags,
    );

  }

  @override
  launch() async{

    await _androidIntent.launch();
  }


}