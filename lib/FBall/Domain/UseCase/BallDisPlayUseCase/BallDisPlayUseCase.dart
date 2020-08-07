import 'dart:convert';

import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class BallDisPlayUseCase {
  FBallResDto _fBallResDto;
  BallDisPlayUseCase(this._fBallResDto);

  String remainTime(){
    return TimeDisplayUtil.getCalcToStrFromNow(_fBallResDto.activationTime);
  }


  String ballLikes() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.ballLikes.toString();
    }
  }


  String ballDisLikes() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.ballDisLikes.toString();
    }
  }


  String commentCount() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.commentCount.toString();
    }
  }


  String profilePictureUrl() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.uid.profilePictureUrl;
    }
  }


  String ballName() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.ballName;
    }
  }


  String placeAddress() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.placeAddress;
    }
  }


  bool isAlive() {
    if(_fBallResDto.activationTime.isAfter(DateTime.now())){
      return true;
    }else {
      return false;
    }
  }


  String ballHits() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.ballHits.toString();
    }
  }


  String  displayMakeTime() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(_fBallResDto.makeTime);
    }
  }


  String  makerNickName() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.uid.nickName;
    }
  }


  String makerFollower() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.uid.followCount.toString();
    }
  }


  String makerInfluencePower() {
    if(_fBallResDto.ballDeleteFlag){
      return "-";
    }else {
      return _fBallResDto.uid.cumulativeInfluence.toString();
    }
  }
}
