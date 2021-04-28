import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FluttertoastAdapter {
  Future<bool?> showToast(
      {required String msg,
      Toast? toastLength,
      int timeInSecForIos = 1,
      double fontSize = 16.0,
      ToastGravity? gravity,
      Color? backgroundColor,
      Color? textColor}) async {
    return await Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIos,
        fontSize: fontSize,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }
  Future<bool?> cancel() async {
    return await Fluttertoast.cancel();
  }

}
