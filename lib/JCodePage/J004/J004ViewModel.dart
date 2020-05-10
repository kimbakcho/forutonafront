import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J006/J006View.dart';
import 'package:provider/provider.dart';

class J004ViewModel extends ChangeNotifier {
  final BuildContext _context;

  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  int remindTimeSec = 120;
  PhoneAuthRepository _phoneAuthRepository = new PhoneAuthRepository();
  PhoneAuthResDto resPhoneAuth;

  TextEditingController authNumberEditingController = TextEditingController();
  Timer secTick;

  J004ViewModel(this._context) {
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
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = _currentIsoCode;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
    resPhoneAuth = await _phoneAuthRepository.reqPhoneAuth(reqDto);
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
    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    reqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.isoCode = _currentIsoCode;
    reqDto.authNumber = authNumberEditingController.text;
    PhoneAuthNumberResDto resDto =
        await _phoneAuthRepository.reqNumberAuthReq(reqDto);
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
      globalModel.fUserInfoJoinReqDto.internationalizedPhoneNumber =
          resDto.internationalizedPhoneNumber;
      globalModel.fUserInfoJoinReqDto.phoneAuthToken = resDto.phoneAuthToken;
      Navigator.of(_context)
          .push(MaterialPageRoute(builder: (_) => J006View()));
    }
  }
}
