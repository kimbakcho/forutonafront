import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DetailPageItemFactory {
  Widget getDetailPageWidget(String ballUuid,FBallType ballType){
    if(ballType == FBallType.IssueBall){
      return ID001MainPage2(ballUuid: ballUuid);
    }else {
      return Container(
        child: Text("do not Support Type")
      );
    }
  }
}