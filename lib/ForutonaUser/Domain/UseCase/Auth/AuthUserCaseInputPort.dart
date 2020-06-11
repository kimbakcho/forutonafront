import 'package:flutter/material.dart';
import 'AuthUserCaseOutputPort.dart';

abstract class AuthUserCaseInputPort {
  Future<bool> checkLogin({AuthUserCaseOutputPort authUserCaseOutputPort});
  Future<String> myUid();
  String userNickName({@required BuildContext context});
}