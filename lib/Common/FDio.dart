import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';

class FDio extends DioForNative {
  FDio(String token) {
    this.options = FBaseOption(token);
  }

  // ignore: non_constant_identifier_names
  BaseOptions FBaseOption(String token) {
    BaseOptions options = BaseOptions();
    options.baseUrl = Preference.baseBackEndUrl;
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

  static makeAuthTokenFDio() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    return dio;
  }
}
