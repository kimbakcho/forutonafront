import 'PwFindEmailUseCaseOutputPort.dart';

abstract class PwFindEmailUseCaseInputPort {
  Future<void> sendPasswordResetEmail(String email,{PwFindEmailUseCaseOutputPort outputPort});
}