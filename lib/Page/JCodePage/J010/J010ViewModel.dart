import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthSupportLanguage.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsReceiverService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:forutonafront/Page/JCodePage/J011/J011View.dart';

class J010ViewModel extends ChangeNotifier {
  final BuildContext context;
  final PhoneFindValidUseCase _phoneFindValidUseCase;
  final TextEditingController authNumberEditingController;
  final PwFindPhoneUseCaseInputPort _pwFindPhoneUseCaseInputPort;

  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  int remindTimeSec = 120;

  PwFindPhoneAuthResDto _resPhoneAuth;

  Timer secTick;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  J010ViewModel(
      {@required this.context,
      @required PhoneFindValidUseCase phoneFindValidUseCase,
      @required this.authNumberEditingController,
      @required PwFindPhoneUseCaseInputPort pwFindPhoneUseCaseInputPort})
      : _phoneFindValidUseCase = phoneFindValidUseCase,
        _pwFindPhoneUseCaseInputPort = pwFindPhoneUseCaseInputPort {
    _startTimerTicker();
  }

  void _startTimerTicker() {
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
    Navigator.of(context).pop();
  }

  void onPhoneNumberChange(
      String phoneNumber, String internationalizedPhoneNumber, String isoCode) {
    _currentPhoneNumber = phoneNumber;
    _currentInternationalizedPhoneNumber = internationalizedPhoneNumber;
    _currentIsoCode = isoCode;
  }

  reqPhoneAuth() async {
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.isoCode = _currentIsoCode;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.internationalizedDialCode = _currentInternationalizedPhoneNumber;
    // reqDto.email = _pwFindPhoneUseCaseInputPort.email;
    _setIsLoading(true);
    await _phoneFindValidUseCase.phoneEmailIdValidWithReqPhoneSmsAuth(reqDto);
    if (_phoneFindValidUseCase.hasPhoneEmailError()) {
      Fluttertoast.showToast(
          msg: _phoneFindValidUseCase.phoneEmailErrorText(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 4,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      _resPhoneAuth = _phoneFindValidUseCase.getPhoneAuth();
      startSmsReceiver();
    }
    _setIsLoading(false);
  }

  void startSmsReceiver() {
    var smsAuthReceiverService =
        SmsAuthReceiverService(onSmsReceived, SmsAuthSupportLanguage.KoKr);
    smsAuthReceiverService.startListening();
  }

  onSmsReceived(String message) {
    authNumberEditingController.text = message;
    notifyListeners();
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
    PwFindPhoneAuthNumberReqDto reqDto = PwFindPhoneAuthNumberReqDto();
    reqDto.internationalizedDialCode = _currentInternationalizedPhoneNumber;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.isoCode = _currentIsoCode;
    reqDto.authNumber = authNumberEditingController.text;
    // reqDto.email = _pwFindPhoneUseCaseInputPort.email;
    _setIsLoading(true);
    await _phoneFindValidUseCase.phoneAuthNumberValid(reqDto);
    if (_phoneFindValidUseCase.hasPhoneAuthNumberError()) {
      Fluttertoast.showToast(
          msg: _phoneFindValidUseCase.phoneAuthNumberErrorText(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {

      // _pwFindPhoneUseCaseInputPort.emailPhoneAuthToken =
      //     _phoneFindValidUseCase.getPwFindPhoneAuthNumber().emailPhoneAuthToken;
      //
      // _pwFindPhoneUseCaseInputPort.internationalizedPhoneNumber =
      //     _phoneFindValidUseCase
      //         .getPwFindPhoneAuthNumber()
      //         .internationalizedDialCode;

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J011View()));
    }
    _setIsLoading(false);
  }
}
