import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J010/J010View.dart';
import 'package:provider/provider.dart';

class J009ViewModel extends ChangeNotifier {
  final BuildContext _context;

  TextEditingController idEditingController = TextEditingController();
  PhoneFindValidService _phoneFindValidService = PhoneFindValidImpl();
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasComplete = false;

  J009ViewModel(this._context) {
    GlobalModel globalModel = Provider.of(_context, listen: false);
    globalModel.pwFindPhoneAuthReqDto = PwFindPhoneAuthReqDto();
  }

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  bool isCanNextBtn() {
    if (idEditingController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }
  onNextComplete() async {
    _setIsLoading(true);
    await _phoneFindValidService.emailIdValid(idEditingController.text);
    _hasComplete = true;
    if (!_phoneFindValidService.hasEmailError()) {
      GlobalModel globalModel = Provider.of(_context, listen: false);
      globalModel.pwFindPhoneAuthReqDto.email = idEditingController.text;
      Navigator.of(_context)
          .push(MaterialPageRoute(builder: (_) => J010View()));
    }
    _setIsLoading(false);
  }

  void onIdEditChangeText(String value) {
    _hasComplete = false;
    notifyListeners();
  }

  Future<void> onIdEditComplete() async {
    _setIsLoading(true);
    await _phoneFindValidService.emailIdValid(idEditingController.text);
    _hasComplete = true;
    _setIsLoading(false);
  }

  bool hasEmailError() {
    if(_hasComplete){
      return _phoneFindValidService.hasEmailError();
    }else {
      return true;
    }

  }

  String emailErrorText() {
    if (_hasComplete) {
      return _phoneFindValidService.emailErrorText();
    } else {
      return "";
    }
  }
}
