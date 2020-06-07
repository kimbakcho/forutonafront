
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';

import 'package:json_annotation/json_annotation.dart';

part 'FBallValuation.g.dart';

@JsonSerializable()
class FBallValuation {
  String valueUuid;
  String ballUuid;
  String uid;
  int upAndDown;
  FBallValuation();

  factory FBallValuation.fromJson(Map<String, dynamic> json) =>
      _$FBallValuationFromJson(json);

  Map<String, dynamic> toJson() => _$FBallValuationToJson(this);

  factory FBallValuation.fromFBallValuationResDto(FBallValuationResDto resDto){
    FBallValuation fBallValuation = FBallValuation();
    if(resDto == null){
      fBallValuation.valueUuid = null;
      fBallValuation.ballUuid = null;
      fBallValuation.uid = null;
      fBallValuation.upAndDown = null;
    }else {
      fBallValuation.valueUuid = resDto.valueUuid;
      fBallValuation.ballUuid = resDto.ballUuid;
      fBallValuation.uid = resDto.uid;
      fBallValuation.upAndDown = resDto.upAndDown;
    }
    return fBallValuation;
  }


  hasValuation(){
    if(valueUuid != null){
      return true;
    }else {
      return false;
    }
  }
  isLikeState(){
    if(hasValuation() && upAndDown > 0){
      return true;
    }else {
      return false;
    }
  }
  isDisLikeState(){
    if(hasValuation() && upAndDown < 0){
      return true;
    }else {
      return false;
    }
  }

}