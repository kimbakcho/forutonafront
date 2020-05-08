import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PhoneAuthRepository.dart';

class J004ViewModel extends ChangeNotifier{
  final BuildContext _context;
  J004ViewModel(this._context);
  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  int remindTimeSec = 120;
  PhoneAuthRepository _phoneAuthRepository = new PhoneAuthRepository();

  void onBackTap() {
    Navigator.of(_context).pop();
  }


  nextBtnFlag() {
    return false;
  }
  onNextBtnClick(){

  }

  void onPhoneNumberChange(String phoneNumber, String internationalizedPhoneNumber, String isoCode) {
    _currentPhoneNumber = phoneNumber;
    _currentInternationalizedPhoneNumber = internationalizedPhoneNumber;
    _currentIsoCode = isoCode;
  }
  reqPhoneAuth() async {
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = _currentIsoCode;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.internationalizedPhoneNumber = _currentPhoneNumber;
    var resPhoneAuth = _phoneAuthRepository.reqPhoneAuth(reqDto);
    print(resPhoneAuth);
  }

  bool isCanRequest() {
    if(_currentInternationalizedPhoneNumber.length >0 ){
      return true;
    }else {
      return false;
    }
  }
}