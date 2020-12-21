import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:forutonafront/Preference.dart';

class MDio extends DioForNative {

  MDio() {
    this.options = mBaseOption();
  }

  BaseOptions mBaseOption() {
    BaseOptions options = BaseOptions();
    options.baseUrl = Preference.managerBaseBackEndUrl;
    options.headers =  {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    return options;
  }

}
