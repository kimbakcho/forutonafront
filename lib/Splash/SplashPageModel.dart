import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

class SplashPageModel with ChangeNotifier {
  FUserRepository _repository = new FUserRepository();
  Future<FUserInfoDto> getFUserInfoDto() async {
      return await _repository.getForutonaUserBasic();
  }
}