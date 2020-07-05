import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'PwFindEmailUseCaseInputPort.dart';

class PwFindEmailUseCase implements PwFindEmailUseCaseInputPort {

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  PwFindEmailUseCase(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      :_fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<void> sendPasswordResetEmail(String email,{PwFindEmailUseCaseOutputPort outputPort}) async {
    await _fireBaseAuthAdapterForUseCase.sendPasswordResetEmail(email);
    outputPort.onSendPasswordResetEmail();
  }

}