import 'package:flutter/material.dart';
import 'AuthUserCaseOutputPort.dart';

abstract class AuthUserCaseInputPort {
  Future<bool> checkLogin({AuthUserCaseOutputPort authUserCaseOutputPort});
  Future<String> userUid();
  String userNickName({@required BuildContext context});
}