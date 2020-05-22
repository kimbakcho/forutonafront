import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetController.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

class IssueBallWidgetStyle3ViewModel extends ChangeNotifier {
  final BuildContext _context;
  final BallStyle3WidgetController ballStyle3WidgetController;
  IssueBallDescriptionDto fBallDescriptionBasic;

  IssueBallWidgetStyle3ViewModel(this.ballStyle3WidgetController, this._context){

    this.fBallDescriptionBasic = IssueBallDescriptionDto.fromJson(
        json.decode(getFBallResDto().description));

  }
  isMainPicture(){
    if(fBallDescriptionBasic.desimages.length > 0){
      return true;
    }else {
      return false;
    }
  }
  getFBallResDto(){
    return ballStyle3WidgetController.fBallResDto;
  }
  void goIssueDetailPage() async{
    await Navigator.of(_context).push(MaterialPageRoute(
        builder: (_)=>ID001MainPage(getFBallResDto().ballUuid)
    ));
    ballStyle3WidgetController.onRequestReFreshBall(getFBallResDto());
  }
}
