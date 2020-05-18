import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/PwFindValid/PhoneFindValidService.dart';
import 'package:forutonafront/Common/SignValid/PwFindValidImpl/PhoneFindValidImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:forutonafront/JCodePage/J011/J011View.dart';
import 'package:provider/provider.dart';

import '../../GlobalModel.dart';

class J010ViewModel extends ChangeNotifier{
  final BuildContext _context;

  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  int remindTimeSec = 120;

  PwFindPhoneAuthResDto _resPhoneAuth;
  PhoneFindValidService _phoneFindValidService = new PhoneFindValidImpl();

  TextEditingController authNumberEditingController = TextEditingController();
  Timer secTick;

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }
  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.isoCode = _currentIsoCode;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.internationalizedPhoneNumber= _currentInternationalizedPhoneNumber;
    reqDto.email = globalModel.pwFindPhoneAuthReqDto.email;
    _setIsLoading(true);
    await _phoneFindValidService.phoneEmailIdValid(reqDto);
    if(_phoneFindValidService.hasPhoneEmailError()){
      Fluttertoast.showToast(
          msg: _phoneFindValidService.phoneEmailErrorText(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 4,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }else {
      globalModel.pwFindPhoneAuthReqDto.isoCode = _currentIsoCode;
      globalModel.pwFindPhoneAuthReqDto.phoneNumber = _currentPhoneNumber;
      globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
      _resPhoneAuth = _phoneFindValidService.getPhoneAuth();
    }
    _setIsLoading(false);
  }

  bool isCanRequest() {
    if (_currentInternationalizedPhoneNumber != null &&
        _currentInternationalizedPhoneNumber.length > 0 &&
        _resPhoneAuth == null) {
      return true;
    } else if (_currentInternationalizedPhoneNumber != null &&
        _currentInternationalizedPhoneNumber.length > 0 &&
        _resPhoneAuth != null &&
        _resPhoneAuth.authRetryAvailableTime.isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  bool isCanAuthNumberReq() {
    if (_resPhoneAuth != null && authNumberEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  int isReqRemindTimeSec() {
    if (_resPhoneAuth == null) {
      return 120;
    } else {
      if (_resPhoneAuth.authRetryAvailableTime
          .difference(DateTime.now())
          .isNegative) {
        return 120;
      } else {
        return _resPhoneAuth.authRetryAvailableTime
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
    _setIsLoading(true);
    await _phoneFindValidService.phoneAuthNumberValid(reqDto);
    if (_phoneFindValidService.hasPhoneAuthNumberError()) {
      Fluttertoast.showToast(
          msg: _phoneFindValidService.phoneAuthNumberErrorText(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      GlobalModel globalModel = Provider.of(_context,listen: false);
      PwFindPhoneAuthNumberResDto resDto = _phoneFindValidService.getPwFindPhoneAuthNumberResDto();
      globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber =
          resDto.internationalizedPhoneNumber;
      globalModel.pwFindPhoneAuthReqDto.emailPhoneAuthToken = resDto.emailPhoneAuthToken;
      Navigator.of(_context)
          .push(MaterialPageRoute(builder: (_) => J011View()));
    }
    _setIsLoading(false);
  }
}