import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/SignValid/PwFindValid/PhoneFindValidService.dart';
import 'package:forutonafront/Common/SignValid/PwFindValidImpl/PhoneFindValidImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:provider/provider.dart';

class J011ViewModel extends ChangeNotifier {
  final BuildContext _context;
  TextEditingController pwEditingController = TextEditingController();
  TextEditingController pwCheckEditingController = TextEditingController();
  PhoneFindValidService _phoneFindValidService = PhoneFindValidImpl();
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }
  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


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
    if (!_phoneFindValidService.hasPwError() &&
        !_phoneFindValidService.hasPwCheckError()) {
      GlobalModel globalModel = Provider.of(_context, listen: false);
      PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
      reqDto.emailPhoneAuthToken =
          globalModel.pwFindPhoneAuthReqDto.emailPhoneAuthToken;
      reqDto.email = globalModel.pwFindPhoneAuthReqDto.email;
      reqDto.password = pwEditingController.text;
      reqDto.internationalizedPhoneNumber =
          globalModel.pwFindPhoneAuthReqDto.internationalizedPhoneNumber;
      _setIsLoading(true);
      await _phoneFindValidService.phonePwChangeWithValid(reqDto);

      if (_phoneFindValidService.hasPhonePwChangeError()) {
        Fluttertoast.showToast(
            msg: _phoneFindValidService.phonePwChangeErrorText(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Color(0xff454F63),
            textColor: Colors.white,
            fontSize: 12.0);
      } else {
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
      }
      _setIsLoading(false);
    }
  }

  void onPwEditComplete() {
    _phoneFindValidService.pwValid(pwEditingController.text);
    notifyListeners();
  }

  void onPwEditChangeText(String value) {
    _phoneFindValidService.pwValid(pwEditingController.text);
    notifyListeners();
  }

  bool hasPwError() {
    return _phoneFindValidService.hasPwError();
  }

  String pwErrorText() {
    if (pwEditingController.text.length > 0) {
      return _phoneFindValidService.pwErrorText();
    } else {
      return "";
    }
  }

  void onPwCheckComplete() {
    _phoneFindValidService.pwCheckValid(
        pwEditingController.text, pwCheckEditingController.text);
    notifyListeners();
  }

  void onPwCheckEditChangeText(String value) {
    _phoneFindValidService.pwCheckValid(
        pwEditingController.text, pwCheckEditingController.text);
    notifyListeners();
  }

  bool hasPwCheckError() {
    return _phoneFindValidService.hasPwCheckError();
  }

  String pwCheckErrorText() {
    if (pwEditingController.text.length > 0) {
      return _phoneFindValidService.pwCheckErrorText();
    } else {
      return "";
    }
  }
}
