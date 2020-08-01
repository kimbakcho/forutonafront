import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class LogoutUseCase implements LogoutUseCaseInputPort {
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  LogoutUseCase(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;

  @override
  Future<void> tryLogout({LogoutUseCaseOutputPort outputPort}) async {
    await _fireBaseAuthAdapterForUseCase.logout();

    var reqSignInUserInfoFromMemory =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();

    if (outputPort != null) {
      outputPort.onLogout();
    }

    SnsLoginModuleAdapter snsLoginModuleAdapter = sl.get(
        instanceName: "SnsLoginModuleAdapter",
        param1: reqSignInUserInfoFromMemory.snsService);

    snsLoginModuleAdapter.logout();
  }
}
