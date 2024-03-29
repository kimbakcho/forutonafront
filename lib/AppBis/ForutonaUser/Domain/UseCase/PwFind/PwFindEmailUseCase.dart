import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';
import 'PwFindEmailUseCaseInputPort.dart';
import 'PwFindEmailUseCaseOutputPort.dart';

@LazySingleton(as: PwFindEmailUseCaseInputPort)
class PwFindEmailUseCase implements PwFindEmailUseCaseInputPort {

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  PwFindEmailUseCase(
      {required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      :_fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<void> sendPasswordResetEmail(String email,{PwFindEmailUseCaseOutputPort? outputPort}) async {
    await _fireBaseAuthAdapterForUseCase.sendPasswordResetEmail(email);
    outputPort!.onSendPasswordResetEmail();
  }

}