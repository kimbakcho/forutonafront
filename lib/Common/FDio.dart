import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class FDio extends DioForNative {
  Preference _preference = sl();

  FDio(String token) {
    this.options = FBaseOption(token);
  }

  // ignore: non_constant_identifier_names
  BaseOptions FBaseOption(String token) {
    BaseOptions options = BaseOptions();
    options.baseUrl = _preference.baseBackEndUrl;
    options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token
    };
    return options;
  }

  factory FDio.noneToken(){
    FDio fDio = new FDio("noneToken");
    return fDio;
  }

  factory FDio.token({@required String idToken}){
    if(idToken == null){
      FDio fDio = new FDio("noneToken");
      return fDio;
    }else {
      FDio dio = FDio(idToken);
      return dio;
    }
  }
}
