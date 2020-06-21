import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';


class FireBaseAuthUseCase implements AuthUserCaseInputPort {
  FireBaseAdapter fireBaseAdapter;

  FireBaseAuthUseCase(
      {@required this.fireBaseAdapter})
      : assert(fireBaseAdapter != null);

  @override
  Future<bool> isLogin({AuthUserCaseOutputPort authUserCaseOutputPort}) async {
    var isLogin = await fireBaseAdapter.isLogin();
    if (authUserCaseOutputPort != null) {
      authUserCaseOutputPort.onLoginCheck(isLogin);
    }
    return isLogin;
  }

  @override
  Future<String> myUid() async {
    return await fireBaseAdapter.userUid();
  }

}
