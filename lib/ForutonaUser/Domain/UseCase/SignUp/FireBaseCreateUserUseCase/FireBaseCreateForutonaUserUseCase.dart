import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateUserUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class FireBaseCreateForutonaUserUseCase
    implements FireBaseCreateUserUseCaseInputPort {
  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  FireBaseCreateForutonaUserUseCase(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<String> createUser({String email, String pw}) async {
    var result = await _fireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(email, pw);
    return result;
  }
}
