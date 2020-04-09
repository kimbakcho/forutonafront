import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class QuestBallWidgetStyle3ViewModel extends ChangeNotifier {
  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescriptionBasic;
  QuestBallWidgetStyle3ViewModel(this.ballResDto){
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

}
