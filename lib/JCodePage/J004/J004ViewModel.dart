import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthSupportLanguage.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsReceiverService.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/JCodePage/J006/J006View.dart';

class J004ViewModel extends ChangeNotifier
    implements PwAuthFromPhoneUseCaseOutputPort {
  final BuildContext context;
  final PwAuthFromPhoneUseCaseInputPort _pwAuthFromPhoneUseCaseInputPort;
  final SingUpUseCaseInputPort _singUpUseCaseInputPort;
  final TextEditingController authNumberEditingController;

  String _currentPhoneNumber;
  String _currentInternationalizedPhoneNumber;
  String _currentIsoCode;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int remindTimeSec = 120;
  PhoneAuthResDto resPhoneAuth;

  Timer secTick;

  J004ViewModel({
    @required this.context,
    @required PwAuthFromPhoneUseCaseInputPort pwAuthFromPhoneUseCaseInputPort,
    @required SingUpUseCaseInputPort singUpUseCaseInputPort,
    @required this.authNumberEditingController,
  })  : _pwAuthFromPhoneUseCaseInputPort = pwAuthFromPhoneUseCaseInputPort,
        _singUpUseCaseInputPort = singUpUseCaseInputPort {
    startSecTickerForPhoneAuthTimer();
  }

  void startSecTickerForPhoneAuthTimer() {
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
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = _currentIsoCode;
    reqDto.phoneNumber = _currentPhoneNumber;
    reqDto.internationalizedPhoneNumber = _currentInternationalizedPhoneNumber;
    _setIsLoading(true);
    await _pwAuthFromPhoneUseCaseInputPort.reqPhoneAuth(reqDto,
        outputPort: this);
    _setIsLoading(false);
    notifyListeners();
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

  onTimeout() {
    print("timeout");
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
        return 120;
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
    await _pwAuthFromPhoneUseCaseInputPort.reqNumberAuthReq(reqDto,outputPort: this);
  }

  @override
  void onPhoneAuth(PhoneAuthResDto resDto) {
    resPhoneAuth = resDto;
    startSmsReceiver();
  }

  @override
  void onNumberAuthReq(PhoneAuthNumberResDto phoneAuthNumberResDto) {
    if (phoneAuthNumberResDto.errorFlag) {
      Fluttertoast.showToast(
          msg: phoneAuthNumberResDto.errorCause,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      _singUpUseCaseInputPort.setInternationalizedPhoneNumber(
          phoneAuthNumberResDto.internationalizedPhoneNumber);
      _singUpUseCaseInputPort
          .setPhoneAuthToken(phoneAuthNumberResDto.phoneAuthToken);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J006View()));
    }
  }
}
