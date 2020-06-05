import 'AuthUserCaseOutputPort.dart';

abstract class AuthUserCaseInputPort {
  Future<bool> checkLogin({AuthUserCaseOutputPort authUserCaseOutputPort});
  Future<String> userUid();
}