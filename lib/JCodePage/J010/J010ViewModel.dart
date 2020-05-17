import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/JCodePage/J011/J011View.dart';
import 'package:provider/provider.dart';

import '../../GlobalModel.dart';

class J010ViewModel extends ChangeNotifier{
  final BuildContext _context;

  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  int remindTimeSec = 120;
  PhoneAuthRepository _phoneAuthRepository = new PhoneAuthRepository();
  PwFindPhoneAuthResDto resPhoneAuth;

  TextEditingController authNumberEditingController = TextEditingController();
  Timer secTick;

  J010ViewModel(this._context) {
    secTick = Timer.periodic(Duration(seconds: 1), (timer) {
      secTick = timer;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    secTick.cancel();
    super.dispose();
  }

  void onBackTap() {
    Navigator.of(_context).pop();
  }


  void onPhoneNumberChange(
      String phoneNumber, String internationalizedPhoneNumber, String isoCode) {
    _currentPhoneNumber = phoneNumber;
    _currentInternationalizedPhoneNumber = internationalizedPhoneNumber;
    _currentIsoCode = isoCode;
  }

  reqPhoneAuth() async {
    GlobalModel globalModel = Provider.of(_context,listen: false);
    globalModel.pwFindPhoneAuthReqDto.isoCode = _currentIsoCode;
    globalModel.pwFindPhoneAuthReqDto.phoneNumber = _currentPhoneNumber;
    globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
    resPhoneAuth = await _phoneAuthRepository.reqPwFindPhoneAuth(globalModel.pwFindPhoneAuthReqDto);
    if(resPhoneAuth.error){
      if(resPhoneAuth.cause == "MissMatchEmailAndPhone" ){
        Fluttertoast.showToast(
            msg: "입력하신 정보와 일치하는 계정이 없습니다.\n"
            "휴대폰 번호를 변경하셨다면, 이메일 인증으로 패스워드를 찾아주세요.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 4,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
        resPhoneAuth = null;
      }

    }
    notifyListeners();
  }

  bool isCanRequest() {
    if (_currentInternationalizedPhoneNumber != null &&
        _currentInternationalizedPhoneNumber.length > 0 &&
        resPhoneAuth == null) {
      return true;
    } else if (_currentInternationalizedPhoneNumber != null &&
        _currentInternationalizedPhoneNumber.length > 0 &&
        resPhoneAuth != null &&
        resPhoneAuth.authRetryAvailableTime.isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  bool isCanAuthNumberReq() {
    if (resPhoneAuth != null && authNumberEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  int isReqRemindTimeSec() {
    if (resPhoneAuth == null) {
      return 120;
    } else {
      if (resPhoneAuth.authRetryAvailableTime
          .difference(DateTime.now())
          .isNegative) {
        return 0;
      } else {
        return resPhoneAuth.authRetryAvailableTime
            .difference(DateTime.now())
            .inSeconds;
      }
    }
  }

  void reqNumberAuthReq() async {
    GlobalModel globalModel = Provider.of(_context,listen: false);
    PwFindPhoneAuthNumberReqDto reqDto = PwFindPhoneAuthNumberReqDto();
    reqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.isoCode = _currentIsoCode;
    reqDto.authNumber = authNumberEditingController.text;
    reqDto.email = globalModel.pwFindPhoneAuthReqDto.email;
    PwFindPhoneAuthNumberResDto resDto =
    await _phoneAuthRepository.reqPwFindNumberAuth(reqDto);
    if (resDto.errorFlag) {
      Fluttertoast.showToast(
          msg: resDto.errorCause,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      GlobalModel globalModel = Provider.of(_context,listen: false);
      globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber =
          resDto.internationalizedPhoneNumber;
      globalModel.pwFindPhoneAuthReqDto.emailPhoneAuthToken = resDto.emailPhoneAuthToken;
      Navigator.of(_context)
          .push(MaterialPageRoute(builder: (_) => J011View()));
    }
  }
}