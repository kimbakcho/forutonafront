import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Preference.dart';


class FDio extends DioForNative {

  FDio(String token) {
    this.options = FBaseOption(token);
  }

  // ignore: non_constant_identifier_names
  BaseOptions FBaseOption(String token) {
    BaseOptions options = BaseOptions();
    options.baseUrl = Preference.baseBackEndUrl;
    options.headers = token.length>0 ? {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token
    } : {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    return options;
  }

  factory FDio.noneToken(){
    FDio fDio = new FDio("");
    return fDio;
  }

  factory FDio.token({required String? idToken}){
    if(idToken == null){
      FDio fDio = new FDio("");
      return fDio;
    }else {
      FDio dio = FDio(idToken);
      return dio;
    }
  }
}
