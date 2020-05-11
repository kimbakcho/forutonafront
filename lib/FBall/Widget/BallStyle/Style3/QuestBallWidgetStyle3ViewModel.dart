import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

class QuestBallWidgetStyle3ViewModel extends ChangeNotifier {
  final BuildContext _context;

  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescriptionBasic;
  QuestBallWidgetStyle3ViewModel(this.ballResDto,this._context){
    this.ballResDto = ballResDto;
    this.fBallDescriptionBasic = FBallDescirptionBasic.fromJson(
        json.decode(this.ballResDto.description));
  }
  isMainPicture(){
    if(fBallDescriptionBasic.desimages.length > 0){
      return true;
    }else {
      return false;
    }
  }
  void goIssueDetailPage() {
    Navigator.of(_context).push(MaterialPageRoute(
        builder: (_)=>ID001MainPage(ballResDto)
    ));
  }

}
