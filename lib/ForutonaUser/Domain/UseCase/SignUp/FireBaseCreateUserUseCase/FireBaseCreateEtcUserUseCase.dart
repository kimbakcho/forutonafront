import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateUserUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class FireBaseCreateEtcUserUseCase
    implements FireBaseCreateUserUseCaseInputPort {

  FireBaseCreateEtcUserUseCase();
  
  @override
  Future<String> createUser({String email, String pw}) async {
    return null;
  }
}
