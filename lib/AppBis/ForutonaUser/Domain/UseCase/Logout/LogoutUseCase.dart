import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LogoutUseCaseInputPort)
class LogoutUseCase implements LogoutUseCaseInputPort {
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final SnsLoginModuleAdapterFactory snsLoginModuleAdapterFactory;

  LogoutUseCase(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required this.snsLoginModuleAdapterFactory})
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

    SnsLoginModuleAdapter snsLoginModuleAdapter = snsLoginModuleAdapterFactory
        .getInstance(reqSignInUserInfoFromMemory.snsService);

    snsLoginModuleAdapter.logout();
    _signInUserInfoUseCaseInputPort.clearUserInfo();
  }
}
