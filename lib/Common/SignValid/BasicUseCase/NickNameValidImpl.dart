import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';

class NickNameValidImpl implements SignValid {
  bool _isTextError = false;
  String _errorText = "";


  @override
  bool? hasValidTry = false;

  FUserRepository _fUserRepository;

  NickNameValidImpl({required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String nickNameText) async {
    hasValidTry = true;
    _isTextError = true;
    _errorText = "";
    if (nickNameText.length < 2) {
      _isTextError = true;
      _errorText = "닉네임은 최소 2글자 이상이어야 합니다.";
      return;
    }
    RegExp regExp1 = new RegExp(r'^(?=.*?[!@#\$&*~\s])');
    if (regExp1.hasMatch(_errorText)) {
      _isTextError = true;
      _errorText = "띄어쓰기와 특수문자는 닉네임에 사용할 수 없습니다.";
      return;
    }

    if (await _fUserRepository.checkNickNameDuplication(nickNameText)) {
      _isTextError = true;
      _errorText = "이미 있는 닉네임입니다.";
    } else {
      _isTextError = false;
      _errorText = "";
    }
  }

}
