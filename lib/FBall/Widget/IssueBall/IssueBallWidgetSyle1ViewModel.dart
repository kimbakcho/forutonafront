import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier {
  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescirptionBasic;

  IssueBallWidgetSyle1ViewModel(FBallResDto ballResDto) {
    this.ballResDto = ballResDto;
    this.fBallDescirptionBasic = FBallDescirptionBasic.fromJson(
        json.decode(this.ballResDto.description));
  }
  isMainPicture(){
    if(this.fBallDescirptionBasic.desimages.length>0){
      return true;
    }else {
      return false;
    }
  }
  String mainPictureSrc(){
    if(isMainPicture()){
      return this.fBallDescirptionBasic.desimages[0].src;
    }else {
      return null;
    }
  }
  int getPicktureCount(){
      return this.fBallDescirptionBasic.desimages.length;
  }


}
