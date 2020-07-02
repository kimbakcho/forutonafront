import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/FaceBookLoginUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

abstract class LoginUseCaseInputPort {
  Future<bool> tryLogin();

  factory LoginUseCaseInputPort.fromLoginService(SnsSupportService snsSupportService){
    //TODO LoginUseCase Factory 가 필요함 아래 Code는 예제.
    LoginUseCaseInputPort loginUseCaseInputPort = FaceBookLoginUseCase();
    return loginUseCaseInputPort;
  }
}