import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:provider/provider.dart';

class J011ViewModel extends ChangeNotifier {
  final BuildContext _context;
  TextEditingController pwEditingController = TextEditingController();
  TextEditingController pwCheckEditingController = TextEditingController();
  bool isPwTextError = false;
  String pwTextErrorText = "";
  bool isPwCheckTextError = false;
  String pwCheckTextErrorText = "";
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();

  J011ViewModel(this._context);

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  bool isValidComplete() {
    if (pwEditingController.text.length > 0 &&
        pwCheckEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  onCompeleteBtnClick() async {
    onPwEditComplete();
    onPwCheckComplete();
    if (!isPwTextError && !isPwCheckTextError) {
      GlobalModel globalModel = Provider.of(_context, listen: false);
      PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
      reqDto.emailPhoneAuthToken =
          globalModel.pwFindPhoneAuthReqDto.emailPhoneAuthToken;
      reqDto.email = globalModel.pwFindPhoneAuthReqDto.email;
      reqDto.password = pwEditingController.text;
      reqDto.internationalizedPhoneNumber =
          globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber;
      var pwChangeFromPhoneAuthResDto =
          await _phoneAuthRepository.reqChangePwAuthPhone(reqDto);
      if (!pwChangeFromPhoneAuthResDto.errorFlag) {
        Fluttertoast.showToast(
            msg: "패스워드를 변경하였습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
        Navigator.pushAndRemoveUntil(
            _context,
            MaterialPageRoute(
                settings: RouteSettings(name: "/J001"),
                builder: (context) {
                  return J001View();
                }),
            ModalRoute.withName('/'));
      } else {
        Fluttertoast.showToast(
            msg: pwChangeFromPhoneAuthResDto.cause,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
      }
    }
  }

  void onPwEditComplete() {
    if (!isPwTypeValid()) {
      isPwTextError = true;
      pwTextErrorText = pwTypeValid();
    } else {
      isPwTextError = false;
      pwTextErrorText = "";
    }
    notifyListeners();
  }

  bool isPwTypeValid() {
    String value = pwEditingController.text;
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(value) ? 1 : 0;
    int match2 = regExp2.hasMatch(value) ? 1 : 0;
    int match3 = regExp3.hasMatch(value) ? 1 : 0;
    int match4 = regExp4.hasMatch(value) ? 1 : 0;
    if (value.length < 8) {
      return false;
    } else if (value.length > 16) {
      return false;
    } else if ((match1 + match2 + match3 + match4) < 3) {
      return false;
    } else {
      return true;
    }
  }

  String pwTypeValid() {
    String value = pwEditingController.text;
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(value) ? 1 : 0;
    int match2 = regExp2.hasMatch(value) ? 1 : 0;
    int match3 = regExp3.hasMatch(value) ? 1 : 0;
    int match4 = regExp4.hasMatch(value) ? 1 : 0;
    if (value.length < 8) {
      return "패스워드가 8자리 이하 입니다.";
    } else if (value.length > 16) {
      return "패스워드가 16자리 이상 입니다.";
    } else if ((match1 + match2 + match3 + match4) < 3) {
      return "영문 소문자,대문자,숫자,특수문자 중 3개 이상 조합";
    } else {
      return "";
    }
  }

  void onPwCheckComplete() {
    if (pwEditingController.text != pwCheckEditingController.text) {
      isPwCheckTextError = true;
      pwCheckTextErrorText = "패스워드가 일치 하지 않습니다.";
    } else {
      isPwCheckTextError = false;
      pwCheckTextErrorText = "";
    }
    notifyListeners();
  }

  bool isPwCheckTypeValid() {
    if (pwEditingController.text.length < 8) {
      return false;
    }
    if (pwEditingController.text != pwCheckEditingController.text) {
      return false;
    } else {
      return true;
    }
  }

  void onPwCheckEditChangeText(String value) {
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    notifyListeners();
  }
}
