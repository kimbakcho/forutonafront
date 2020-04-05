import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class SplashPageViewModel with ChangeNotifier {
  final BuildContext context;
  GlobalModel globalModel;

  FUserRepository repository = new FUserRepository();

  SplashPageViewModel(this.context){
    this.globalModel = Provider.of<GlobalModel>(context);
  }
  Future<FUserInfoDto> getFUserInfoDto() async {
      if(globalModel != null){
        globalModel.fUserInfoDto = await repository.getForutonaUserBasic();
      }
      return globalModel.fUserInfoDto;
  }


}