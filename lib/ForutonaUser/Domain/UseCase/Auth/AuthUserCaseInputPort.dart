import 'package:flutter/material.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'AuthUserCaseOutputPort.dart';

abstract class AuthUserCaseInputPort {
  Future<bool> isLogin({AuthUserCaseOutputPort authUserCaseOutputPort});
  Future<String> myUid();

}