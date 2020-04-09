import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallWidgetStyle3ViewModel extends ChangeNotifier {
  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescriptionBasic;
  IssueBallWidgetStyle3ViewModel(this.ballResDto){
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
