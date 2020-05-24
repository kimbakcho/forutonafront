import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GCodePage/G001/G001MainPageInter.dart';

class G001MainPageViewModel extends ChangeNotifier implements G001MainPageInter{
  FUserInfoResDto _fUserInfoResDto;
  FUserRepository _fUserRepository = new FUserRepository();
  CodeCountry _countryCode = new CodeCountry();

  G001MainPageViewModel() {
    _init();
  }

  _init() async {
    _fUserInfoResDto = await _fUserRepository.getForutonaGetMe();
    notifyListeners();
  }

  @override
  reFreshUserInfo() async{
    _fUserInfoResDto = null;
    _fUserInfoResDto = await _fUserRepository.getForutonaGetMe();
    notifyListeners();
  }


  ImageProvider getUserProfileImage() {
    if (_fUserInfoResDto != null) {
      return NetworkImage(_fUserInfoResDto.profilePictureUrl);
    } else {
      return AssetImage("assets/basicprofileimage.png");
    }
  }

  String getUserNickName() {
    if (_fUserInfoResDto != null) {
      return _fUserInfoResDto.nickName;
    } else {
      return "로 딩 중";
    }
  }

  String getUserCountry() {
    if (_fUserInfoResDto != null) {
      return _countryCode.findCountryName(_fUserInfoResDto.isoCode);
    } else {
      return "";
    }
  }

  String getUserSelfIntroduction(){
    if (_fUserInfoResDto != null) {
      if(_fUserInfoResDto.selfIntroduction == null || _fUserInfoResDto.selfIntroduction.trim().length == 0){
        return "여기를 눌러 소개글을 작성하실 수 있습니다.";
      }else {
        return _fUserInfoResDto.selfIntroduction;
      }
    } else {
      return "";
    }
  }
  bool getHaveUserSelfIntroduction(){
    if (_fUserInfoResDto != null) {
      if(_fUserInfoResDto.selfIntroduction == null || _fUserInfoResDto.selfIntroduction.trim().length == 0){
        return false;
      }else {
        return true;
      }
    } else {
      return true;
    }
  }






}
