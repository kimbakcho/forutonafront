import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAdapter {
  final noneToken = "noneToken";

   Future<String> getFireBaseIdToken() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser == null){
      return noneToken;
    }
    var idTokenResult = await firebaseUser.getIdToken(refresh: true);
    return idTokenResult.token;
  }

  Future<bool> isLogin() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser == null){
      return false;
    }else {
      return true;
    }
  }

  Future<String> userUid() async {
     if(await isLogin()){
       var firebaseUser = await FirebaseAuth.instance.currentUser();
       return firebaseUser.uid;
     }else {
       throw new FireBaseAdapterException("no Login statue");
     }
  }
}

class FireBaseAdapterException implements Exception{
  String errMsg;

  FireBaseAdapterException(this.errMsg);
}