import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class FireBaseAuthUseCase implements AuthUserCaseInputPort{
  static final FireBaseAuthUseCase _singleton = new FireBaseAuthUseCase._internal();

  factory FireBaseAuthUseCase() { return _singleton; }

  FirebaseAuth _firebaseAuth;

  FireBaseAuthUseCase._internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<bool> checkLogin({AuthUserCaseOutputPort authUserCaseOutputPort}) async {
     var firebaseUser = await _firebaseAuth.currentUser();
     bool isLogin;
     if(firebaseUser != null){
       isLogin = true;
     }else {
       isLogin = false;
     }
     if(authUserCaseOutputPort != null){
       authUserCaseOutputPort.onLoginCheck(isLogin);
     }
     return isLogin;
  }

  @override
  Future<String> myUid() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return firebaseUser.uid;
  }

  @override
  String userNickName({@required BuildContext context}) {
    GlobalModel globalModel = Provider.of(context,listen: false);
    return globalModel.fUserInfoDto.nickName;
  }

}