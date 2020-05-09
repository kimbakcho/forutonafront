import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
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
  Future<FUserInfoResDto> getFUserInfoDto() async {
      if(globalModel != null){
        globalModel.fUserInfoDto = await repository.getForutonaGetMe();
      }
      return globalModel.fUserInfoDto;
  }
}