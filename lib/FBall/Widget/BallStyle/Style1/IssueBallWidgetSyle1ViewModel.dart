import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier {
  final BuildContext _context;
  final FBallResDto ballResDto;
  IssueBallDescriptionDto fBallDescriptionBasic;
  final Function(FBallResDto) onRequestReFreshBall;

  //Loading
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IssueBallWidgetSyle1ViewModel(this.ballResDto, this._context,this.onRequestReFreshBall) {
    this.fBallDescriptionBasic = IssueBallDescriptionDto.fromJson(
        json.decode(this.ballResDto.description));
  }

  bool isAliveBall() {
    return this.ballResDto.activationTime.isAfter(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
  }

  isMainPicture() {
    if (fBallDescriptionBasic.desimages.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  String mainPictureSrc() {
    if (isMainPicture()) {
      return fBallDescriptionBasic.desimages[0].src;
    } else {
      return null;
    }
  }

  int getPicktureCount() {
    return fBallDescriptionBasic.desimages.length;
  }

  void goIssueDetailPage() async {
    await Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => ID001MainPage(ballResDto)));
//    var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
//    var ballResDto1 = await fBallTypeRepository
//        .selectBall(FBallReqDto(FBallType.IssueBall, ballResDto.ballUuid));
//    this.ballResDto.ballDeleteFlag = ballResDto1.ballDeleteFlag;
//    if(!ballResDto1.ballDeleteFlag){
//      var position = await Geolocator().getLastKnownPosition();
//      ballResDto1.distanceWithMapCenter = await Geolocator().distanceBetween(
//          ballResDto1.latitude,
//          ballResDto1.longitude,
//          position.latitude,
//          position.longitude);
//      ballResDto1.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(
//          ballResDto1.distanceWithMapCenter);
//      this.fBallDescriptionBasic = IssueBallDescriptionDto.fromJson(
//          json.decode(ballResDto1.description));
//    }
    this.onRequestReFreshBall(ballResDto);
  }

  String getBallName(){
    if(ballResDto.ballDeleteFlag){
      return "(삭제됨)${ballResDto.ballName}";
    }else {
      return ballResDto.ballName;
    }
  }

  String getPlaceAddress(){
    if(ballResDto.ballDeleteFlag){
      return "";
    }else {
      return ballResDto.ballName;
    }
  }

  String getDistanceDisplayText(){
    if(ballResDto.ballDeleteFlag){
      return "";
    }else {
      return ballResDto.distanceDisplayText;
    }
  }

  String getProfilePicktureUrl(){
    if(ballResDto.ballDeleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return ballResDto.profilePicktureUrl;
    }
  }

  String getNickName(){
    if(ballResDto.ballDeleteFlag){
      return "";
    }else {
      return ballResDto.nickName;
    }
  }

  String getRemainingTime(){
    if(ballResDto.ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getRemainingToStrFromNow(
          this.ballResDto.activationTime);
    }
  }

  String getCommentCount(){
    if(ballResDto.ballDeleteFlag){
      return "-";
    }else {
      return this.ballResDto.commentCount.toString();
    }
  }

  String getDisLikeCount(){
    if(ballResDto.ballDeleteFlag){
      return "-";
    }else {
      return this.ballResDto.ballDisLikes.toString();
    }
  }

  String getLikeCount(){
    if(ballResDto.ballDeleteFlag){
      return "-";
    }else {
      return this.ballResDto.ballLikes.toString();
    }
  }
}
