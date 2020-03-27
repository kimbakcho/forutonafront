import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';

class SplashPageViewModel with ChangeNotifier {

  GlobalModel globalModel;

  FUserRepository _repository = new FUserRepository();

  SplashPageViewModel(GlobalModel globalModel){
    this.globalModel = globalModel;
  }
  Future<FUserInfoDto> getFUserInfoDto() async {
      if(globalModel != null){
        this.globalModel.fUserInfoDto = await _repository.getForutonaUserBasic();
      }
      return this.globalModel.fUserInfoDto;
  }


}