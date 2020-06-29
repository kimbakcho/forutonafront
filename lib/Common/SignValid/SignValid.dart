import 'package:flutter/cupertino.dart';

abstract class SignValid {
  Future<void> valid(String validText);
  bool hasError();
  String errorText();
}