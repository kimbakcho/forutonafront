import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';

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
  Future<String> userUid() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return firebaseUser.uid;
  }

}