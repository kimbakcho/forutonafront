import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Components/CountrySelect/CountrySelectButton.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';

import 'PhoneAuthMode/PhoneAuthModeUseCase.dart';

class PhoneAuthComponent extends StatefulWidget {
  final PhoneAuthComponentController? phoneAuthComponentController;

  final PhoneAuthMode? phoneAuthMode;

  final String? email;

  const PhoneAuthComponent(
      {Key? key,
      this.phoneAuthComponentController,
      this.phoneAuthMode,
      this.email})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhoneAuthComponentState(
        phoneAuthComponentController: phoneAuthComponentController);
  }
}

class _PhoneAuthComponentState extends State<PhoneAuthComponent>
    with SingleTickerProviderStateMixin {
  final PhoneAuthComponentController? phoneAuthComponentController;

  _PhoneAuthComponentState({this.phoneAuthComponentController});

  Ticker? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {});
    });
    _ticker!.start();
  }

  @override
  void dispose() {
    _ticker!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PhoneAuthComponentViewModel(
            phoneAuthComponentController: phoneAuthComponentController,
            phoneAuthModeFactory: sl(),
            phoneAuthMode: widget.phoneAuthMode,
            phoneAuthUseCaseInputPort: sl(),
            email: widget.email),
        child:
            Consumer<PhoneAuthComponentViewModel>(builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  width: 170,
                  child: CountrySelectButton(
                    countrySelectButtonController:
                        model._countrySelectButtonController,
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: Stack(children: [
                    Container(
                      child: TextField(
                          controller: model._currentPhoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              errorText: model.hasPhoneNumberError
                                  ? model.phoneErrorText
                                  : null,
                              hintText: "휴대폰 번호 입력(‘-’제외)")),
                    ),
                    Positioned(
                        right: 0,
                        top: 8,
                        width: 76,
                        height: 30,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  if (model.isActiveAuthButton) {
                                    model.sendAuthSms();
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: model.isActiveAuthButton
                                        ? Color(0xff3497FD)
                                        : Color(0xffD4D4D4),
                                  ),
                                  child: Center(
                                      child: Text(model._activeButtonText,
                                          style: GoogleFonts.notoSans(
                                            fontSize: 10,
                                            color: const Color(0xffffffff),
                                            letterSpacing: 0.2,
                                          ))),
                                ))))
                  ]))
                ]),
                SizedBox(
                  height: 17,
                ),
                Row(children: [
                  Expanded(
                      child: Stack(children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "인증번호 입력",
                          errorText: model._isAuthNumberError
                              ? model._authCheckErrorText
                              : null),
                      controller: model._currentAuthNumberController,
                      keyboardType: TextInputType.number,
                    ),
                    model._isDisplayCanAuthNumberTime
                        ? Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                                child: Text(
                              '${model._authNumberRemindTime}',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xffff4f9a),
                                letterSpacing: -0.28,
                                height: 1.2142857142857142,
                              ),
                            )))
                        : Container(),
                  ]))
                ])
              ]));
        }));
  }
}

class PhoneAuthComponentViewModel extends ChangeNotifier {
  CountrySelectButtonController? _countrySelectButtonController;

  PhoneAuthComponentController? phoneAuthComponentController;

  final TextEditingController _currentPhoneNumberController;

  final TextEditingController _currentAuthNumberController;

  final PhoneAuthModeFactory phoneAuthModeFactory;

  final PhoneAuthMode? phoneAuthMode;

  DateTime? authRemindTime;

  PhoneAuthUseCaseInputPort? phoneAuthUseCaseInputPort;

  bool _isAuthNumberError = false;

  bool _isTryReqAuthNumber = false;

  String _authCheckErrorText = "";

  bool hasPhoneNumberError = false;

  String phoneErrorText = "";

  PhoneAuthModeUseCase? _phoneAuthModeUseCase;

  String? email;

  OTPTextEditController? otpTextEditController;

  PhoneAuthComponentViewModel(
      {this.phoneAuthComponentController,
      required this.phoneAuthUseCaseInputPort,
      required this.phoneAuthModeFactory,
      this.phoneAuthMode,
      this.email})
      : _currentPhoneNumberController = TextEditingController(),
        _currentAuthNumberController = TextEditingController() {
    if (phoneAuthComponentController != null) {
      phoneAuthComponentController!._phoneAuthComponentViewModel = this;
    }

    _countrySelectButtonController = CountrySelectButtonController(
        onCurrentCountryItem: (CountryItem countryItem) {
      notifyListeners();
    });

    _currentPhoneNumberController.addListener(() {
      notifyListeners();
    });

    _phoneAuthModeUseCase = phoneAuthModeFactory.getInstance(
        phoneAuthMode!, phoneAuthComponentController!,
        email: email);
  }

  sendAuthSms() async {
    await _phoneAuthModeUseCase!.sendAuthSms();
  }

  waitSmsRetrieved() async {
    otpTextEditController =
        OTPTextEditController(codeLength: 6, onCodeReceive: (value) {});
    otpTextEditController!.startListenRetriever((value) {
      var indexOf = value!.indexOf("인증번호:");
      var indexOf2 = value.indexOf("]", indexOf);
      var authNumber = value.substring(indexOf + 5, indexOf2);
      _currentAuthNumberController.text = authNumber;
      return "";
    });
  }


  @override
  void dispose() {
    super.dispose();
    this.otpTextEditController!.stopListen();
  }

  get isActiveAuthButton {
    if (_currentPhoneNumberController.text.length >= 9 &&
        _currentPhoneNumberController.text.length <= 11) {
      if (authRemindTime == null || DateTime.now().isAfter(authRemindTime!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  String get reActiveTime {
    if (authRemindTime == null) {
      return "02:00";
    } else if (authRemindTime!.isAfter(DateTime.now())) {
      var difference = authRemindTime!.difference(DateTime.now());
      if (difference.inSeconds > 120) {
        return "02:00";
      }
      return "${difference.inMinutes.toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}";
    } else {
      return "02:00";
    }
  }

  DateTime? _canAuthNumberTime;

  _checkAuthCheckNumber() async {
    await _phoneAuthModeUseCase!.checkAuthCheckNumber();
  }

  void onNumberAuthReq(PhoneAuthNumberResDto? phoneAuthNumberResDto) {
    if (phoneAuthNumberResDto!.errorFlag!) {
      _isAuthNumberError = true;
      _authCheckErrorText = phoneAuthNumberResDto.errorCause!;
    } else {
      if (phoneAuthComponentController != null) {
        phoneAuthComponentController!
            .onPhoneAuthCheckSuccess!(phoneAuthNumberResDto);
      }
    }
  }

  void onPhoneAuth(PhoneAuthResDto resDto) {
    authRemindTime = resDto.authRetryAvailableTime!;
    _canAuthNumberTime = resDto.authTime!;
    _isTryReqAuthNumber = true;
    if (phoneAuthComponentController != null) {
      phoneAuthComponentController!.onTryAuthReqSuccess!();
    }
    notifyListeners();
  }

  bool get _isDisplayCanAuthNumberTime {
    if (_canAuthNumberTime != null &&
        _isTryReqAuthNumber &&
        _canAuthNumberTime!.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  String get _authNumberRemindTime {
    if (_canAuthNumberTime != null) {
      var difference = _canAuthNumberTime!.difference(DateTime.now());
      return "${difference.inMinutes.toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}";
    } else {
      return "";
    }
  }

  String get _activeButtonText {
    if (!_isTryReqAuthNumber) {
      return "인증 번호 요청";
    }
    if (isActiveAuthButton) {
      return "인증 번호 요청";
    } else {
      return reActiveTime;
    }
  }

  setPhoneError(String phoneError) {
    hasPhoneNumberError = true;
    phoneErrorText = phoneError;
    notifyListeners();
  }

  phoneErrorClear() {
    hasPhoneNumberError = false;
    phoneErrorText = "";
    notifyListeners();
  }
}

class PhoneAuthComponentController {
  PhoneAuthComponentViewModel? _phoneAuthComponentViewModel;

  final Function(PhoneAuthNumberResDto)? onPhoneAuthCheckSuccess;

  final Function? onTryAuthReqSuccess;

  PhoneAuthComponentController(
      {this.onPhoneAuthCheckSuccess, this.onTryAuthReqSuccess});

  checkAuthCheckNumber() {
    _phoneAuthComponentViewModel!._checkAuthCheckNumber();
  }

  CountryItem getCountrySelectItem() {
    return _phoneAuthComponentViewModel!._countrySelectButtonController!
        .getCurrentCountryItem();
  }

  String getPhoneNumber() {
    return _phoneAuthComponentViewModel!._currentPhoneNumberController.text;
  }

  Future<void> waitSmsRetrieved() async {
    await _phoneAuthComponentViewModel!.waitSmsRetrieved();
  }

  resPhoneAuth(PhoneAuthResDto resDto) {
    _phoneAuthComponentViewModel!.onPhoneAuth(resDto);
  }

  String getAuthNumber() {
    return _phoneAuthComponentViewModel!._currentAuthNumberController.text;
  }

  resNumberAuthReq(PhoneAuthNumberResDto? phoneAuthNumberResDto) {
    _phoneAuthComponentViewModel!.onNumberAuthReq(phoneAuthNumberResDto);
  }

  setPhoneError(String phoneError) {
    _phoneAuthComponentViewModel!.setPhoneError(phoneError);
  }

  phoneErrorClear() {
    _phoneAuthComponentViewModel!.phoneErrorClear();
  }
}
