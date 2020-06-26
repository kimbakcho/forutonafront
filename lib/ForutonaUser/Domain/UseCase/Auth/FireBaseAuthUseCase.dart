import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class FireBaseAuthUseCase implements AuthUserCaseInputPort {
  FireBaseAuthAdapterForUseCase _fireBaseAdapter;

  FireBaseAuthUseCase({@required FireBaseAuthAdapterForUseCase fireBaseAdapter})
      : _fireBaseAdapter = fireBaseAdapter;

  @override
  Future<bool> isLogin({AuthUserCaseOutputPort authUserCaseOutputPort}) async {
    var isLogin = await _fireBaseAdapter.isLogin();
    if (authUserCaseOutputPort != null) {
      authUserCaseOutputPort.onLoginCheck(isLogin);
    }
    return isLogin;
  }

  @override
  Future<String> myUid() async {
    return await _fireBaseAdapter.userUid();
  }
}
