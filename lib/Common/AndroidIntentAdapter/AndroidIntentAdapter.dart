import 'package:android_intent/android_intent.dart';

abstract class AndroidIntentAdapter {
   // ignore: non_constant_identifier_names
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