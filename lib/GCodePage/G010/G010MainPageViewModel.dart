import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:image_picker/image_picker.dart';

class G010MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  FUserRepository _fUserRepository = new FUserRepository();
  FUserInfoResDto _fUserInfoResDto;
  CodeCountry _countryCode = new CodeCountry();
  File _currentPickProfileImage;
  String _currentIsoCode;

  bool isChangeProfileImage = false;
  TextEditingController nickNameController = new TextEditingController();
  TextEditingController userIntroduceController = new TextEditingController();
  int nickNameInputTextLength = 0;
  int userIntroduceInputTextLength = 0;
  bool isCanNotUseNickNameDisPlay = false;
  ImageProvider currentProfileImage;




  G010MainPageViewModel(this._context) {
    currentProfileImage = AssetImage("assets/basicprofileimage.png");
    _init();
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
  }


  _init() async {
    _fUserInfoResDto = await _fUserRepository.getForutonaGetMe();
    currentProfileImage = NetworkImage(_fUserInfoResDto.profilePictureUrl);
    _currentIsoCode = _fUserInfoResDto.isoCode;
    nickNameController.text = _fUserInfoResDto.nickName;
    userIntroduceController.text = _fUserInfoResDto.selfIntroduction;
    notifyListeners();
  }

  onCompleteTap() async {
    //자기 자신의 닉네임과 같을때는 체크 안함
    if(onEditCompleteNickName()){
      return ;
    }

    //프로필 이미지 변경 체크 및 업데이트
    if(isChangeProfileImage && _currentPickProfileImage != null){
      String imageUrl = await _fUserRepository.updateUserProfileImage(_currentPickProfileImage);
    }
    FuserAccountUpdateReqdto reqDto = new FuserAccountUpdateReqdto(_currentIsoCode,nickNameController.text,userIntroduceController.text);
    var result = await _fUserRepository.updateAccountUserInfo(reqDto);
    if(result == 1){
      Navigator.of(_context).pop();
    }
  }

  _onNickNameControllerListener() {
    nickNameInputTextLength = nickNameController.text.length;
    isCanNotUseNickNameDisPlay = false;
    notifyListeners();
  }

  onChangeProfileImageTab() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    _currentPickProfileImage = file;
    currentProfileImage = FileImage(file);
    isChangeProfileImage =true;
    notifyListeners();
  }

  onEditCompleteNickName() async {
    RegExp regExp1 = new RegExp(r'^(?=.*?[!@#\$&*~\s])');
    if(regExp1.hasMatch(nickNameController.text)){
      isCanNotUseNickNameDisPlay = true;
    }
    if((_fUserInfoResDto.nickName != nickNameController.text) && !isCanNotUseNickNameDisPlay ){
      var nickNameDuplicationCheckResDto = await _fUserRepository.checkNickNameDuplication(nickNameController.text);
      if(nickNameDuplicationCheckResDto.haveNickName){
        isCanNotUseNickNameDisPlay = true;
      }else {
        isCanNotUseNickNameDisPlay = false;
      }
      notifyListeners();
    }
    notifyListeners();
    return isCanNotUseNickNameDisPlay;
  }

  __onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
  }

  bool isValidComplete() {
    if (nickNameController.text.length > 0 && !isCanNotUseNickNameDisPlay) {
      return true;
    } else {
      return false;
    }
  }

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }


  String getUserCountry() {
    if (_fUserInfoResDto != null) {
      return _countryCode.findCountryName(_currentIsoCode);
    } else {
      return "";
    }
  }

  jumpCountrySelect() async {
    String isoCode = await Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => CountrySelectPage(
              countryCode: _fUserInfoResDto.isoCode,
            )));
    _currentIsoCode = isoCode;
    notifyListeners();
  }
}
