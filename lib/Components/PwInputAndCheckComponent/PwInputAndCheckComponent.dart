import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwCheckValidImpl.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/PwValidImpl.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PwInputAndCheckComponent extends StatelessWidget {
  final PwInputAndCheckComponentController pwInputAndCheckComponentController;

  const PwInputAndCheckComponent(
      {Key key, this.pwInputAndCheckComponentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PwInputAndCheckComponentViewModel(
            pwInputAndCheckComponentController:
                pwInputAndCheckComponentController),
        child: Consumer<PwInputAndCheckComponentViewModel>(
            builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text("패스워드",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    )),
                Row(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        TextField(
                            controller: model._pwEditController,
                            obscureText: true,
                            decoration: InputDecoration(
                                errorText: model._isPwError
                                    ? model._pwErrorText
                                    : null,
                                hintText: "패스워드 입력",
                                hintStyle: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xffb1b1b1),
                                  letterSpacing: -0.28,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2142857142857142,
                                ))),
                        Positioned(
                            right: 0,
                            top: 13,
                            child: model._pwSatisfied
                                ? Icon(Icons.check_circle, color: Colors.blue)
                                : Container())
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text("패스워드 확인",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          TextField(
                              controller: model._pwCheckEditController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: model._isPwCheckError
                                      ? model._pwCheckErrorText
                                      : null,
                                  hintText: "패스워드 입력",
                                  hintStyle: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xffb1b1b1),
                                    letterSpacing: -0.28,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2142857142857142,
                                  ))),
                          Positioned(
                              right: 0,
                              top: 13,
                              child: model._pwCheckSatisfied
                                  ? Icon(Icons.check_circle, color: Colors.blue)
                                  : Container())
                        ],
                      ),
                    )
                  ],
                ),
              ]));
        }));
  }
}

class PwInputAndCheckComponentViewModel extends ChangeNotifier {
  final PwInputAndCheckComponentController pwInputAndCheckComponentController;

  TextEditingController _pwEditController;
  TextEditingController _pwCheckEditController;

  PwValid _pwValid = PwValidImpl();

  SignValid _pwCheckValid;

  bool _tryValid = false;

  bool _isPwError = false;

  String _pwErrorText = "";

  bool _isPwCheckError = false;

  String _pwCheckErrorText = "";

  PwInputAndCheckComponentViewModel({this.pwInputAndCheckComponentController})
      : _pwEditController = TextEditingController(),
        _pwCheckEditController = TextEditingController() {
    if (pwInputAndCheckComponentController != null) {
      pwInputAndCheckComponentController._pwInputAndCheckComponentViewModel =
          this;
    }
    _pwEditController.addListener(() {
      _onChangeEditValue(_pwEditController.text, _pwCheckEditController.text);
    });
    _pwCheckEditController.addListener(() {
      _onChangeEditValue(_pwEditController.text, _pwCheckEditController.text);
    });
    _pwCheckValid = PwCheckValidImpl(_pwValid);
  }

  _onChangeEditValue(String pw, String pwCheck) {
    if (pwInputAndCheckComponentController != null &&
        pwInputAndCheckComponentController.onChangeEditValue != null) {
      pwInputAndCheckComponentController.onChangeEditValue(pw, pwCheck);
    }
  }

  Future<bool> _valid() async {
    _tryValid = true;

    await _pwValid.valid(_pwEditController.text);

    _isPwError = _pwValid.hasError();
    _pwErrorText = _pwValid.errorText();

    if (_isPwError) {
      return false;
    }

    await _pwCheckValid.valid(_pwCheckEditController.text);
    _isPwCheckError = _pwCheckValid.hasError();
    _pwCheckErrorText = _pwCheckValid.errorText();

    if (_isPwCheckError) {
      return false;
    }
    return true;
  }

  bool get _pwSatisfied {
    if (_tryValid && !_isPwError) {
      return true;
    } else {
      return false;
    }
  }

  bool get _pwCheckSatisfied {
    if (_tryValid && !_isPwCheckError) {
      return true;
    } else {
      return false;
    }
  }
}

class PwInputAndCheckComponentController {
  PwInputAndCheckComponentViewModel _pwInputAndCheckComponentViewModel;

  Function(String, String) onChangeEditValue;

  PwInputAndCheckComponentController({this.onChangeEditValue});

  Future<bool> valid() async {
    var result = await _pwInputAndCheckComponentViewModel._valid();

    _pwInputAndCheckComponentViewModel.notifyListeners();

    return result;
  }
  String getPwValue() {
    return _pwInputAndCheckComponentViewModel._pwEditController.text;
  }
}
