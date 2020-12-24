import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Common/Country/CountrySelectButton.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class PhoneAuthComponent extends StatefulWidget {
  final PhoneAuthComponentController phoneAuthComponentController;

  const PhoneAuthComponent({Key key, this.phoneAuthComponentController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhoneAuthComponentState(
        phoneAuthComponentController: phoneAuthComponentController);
  }
}

class _PhoneAuthComponentState extends State<PhoneAuthComponent>
    with SingleTickerProviderStateMixin {
  final PhoneAuthComponentController phoneAuthComponentController;

  _PhoneAuthComponentState({this.phoneAuthComponentController});

  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PhoneAuthComponentViewModel(
            phoneAuthComponentController: phoneAuthComponentController,
            phoneAuthUseCaseInputPort: sl()),
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
                          decoration:
                              InputDecoration(hintText: "휴대폰 번호 입력(‘-’제외)")),
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
                                        child: Text("인증 번호 요청",
                                            style: GoogleFonts.notoSans(
                                              fontSize: 10,
                                              color: const Color(0xffffffff),
                                              letterSpacing: 0.2,
                                            )))))))
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
                          errorText:
                              model._isAuthNumberError ? "인증 숫자 틀림" : null),
                      controller: model._currentAuthNumberController,
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            child: Text(
                          '${model.reActiveTime}',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xffff4f9a),
                            letterSpacing: -0.28,
                            height: 1.2142857142857142,
                          ),
                        )))
                  ]))
                ])
              ]));
        }));
  }
}

class PhoneAuthComponentViewModel extends ChangeNotifier
    implements PwAuthFromPhoneUseCaseOutputPort {
  CountrySelectButtonController _countrySelectButtonController;

  PhoneAuthComponentController phoneAuthComponentController;

  final TextEditingController _currentPhoneNumberController;
  final TextEditingController _currentAuthNumberController;

  DateTime authRemindTime;

  PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;

  bool _isAuthNumberError = false;

  PhoneAuthComponentViewModel(
      {this.phoneAuthComponentController,
      @required this.phoneAuthUseCaseInputPort})
      : _currentPhoneNumberController = TextEditingController(),
        _currentAuthNumberController = TextEditingController(){
    if (phoneAuthComponentController != null) {
      phoneAuthComponentController._phoneAuthComponentViewModel = this;
    }

    _countrySelectButtonController = CountrySelectButtonController(
        onCurrentCountryItem: (CountryItem countryItem) {
      notifyListeners();
    });

    _currentPhoneNumberController.addListener(() {
      notifyListeners();
    });
  }

  sendAuthSms() async {
    var currentCountryItem =
        this._countrySelectButtonController.getCurrentCountryItem();
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = currentCountryItem.code;
    reqDto.phoneNumber = _currentPhoneNumberController.text;
    reqDto.internationalizedPhoneNumber = currentCountryItem.dialCode;
    await phoneAuthUseCaseInputPort.reqPhoneAuth(reqDto, outputPort: this);

    var authCode = await SmsRetrieved.startListeningSms();

    var indexOf = authCode.indexOf("인증번호:");
    var indexOf2 = authCode.indexOf("]",indexOf);
    var authNumber = authCode.substring(indexOf+5,indexOf2);

    _currentAuthNumberController.text = authNumber;

  }

  get isActiveAuthButton {
    if (_currentPhoneNumberController.text.length >= 9 &&
        _currentPhoneNumberController.text.length <= 11) {
      if (authRemindTime == null || DateTime.now().isAfter(authRemindTime)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  get reActiveTime {
    if (authRemindTime == null) {
      return "02:00";
    } else if (authRemindTime.isAfter(DateTime.now())) {
      var difference = authRemindTime.difference(DateTime.now());
      if (difference.inSeconds > 120) {
        return "02:00";
      }
      return "${difference.inMinutes.toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}";
    } else {
      return "02:00";
    }
  }

  _checkAuthCheckNumber(){
    //TODO 해당 부분 개발 필요
    phoneAuthUseCaseInputPort.reqNumberAuthReq(reqDto)
  }

  @override
  void onNumberAuthReq(PhoneAuthNumberResDto phoneAuthNumberResDto) {
    // TODO: implement onNumberAuthReq
  }

  @override
  void onPhoneAuth(PhoneAuthResDto resDto) {
    authRemindTime = resDto.authRetryAvailableTime;
    notifyListeners();
  }
}

class PhoneAuthComponentController {
  PhoneAuthComponentViewModel _phoneAuthComponentViewModel;

  checkAuthCheckNumber(){
    _phoneAuthComponentViewModel._checkAuthCheckNumber();
  }
}
