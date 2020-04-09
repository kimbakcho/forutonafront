import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier {
  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescriptionBasic;
  IssueBallWidgetSyle1ViewModel(FBallResDto ballResDto) {
    this.ballResDto = ballResDto;
    this.fBallDescriptionBasic = FBallDescirptionBasic.fromJson(
        json.decode(this.ballResDto.description));

  }

  bool isAliveBall(){
    return this.ballResDto.activationTime.isAfter(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();

  }

  isMainPicture(){
    if(fBallDescriptionBasic.desimages.length>0){
      return true;
    }else {
      return false;
    }
  }
  String mainPictureSrc(){
    if(isMainPicture()){
      return fBallDescriptionBasic.desimages[0].src;
    }else {
      return null;
    }
  }
  int getPicktureCount(){
    return fBallDescriptionBasic.desimages.length;
  }



}