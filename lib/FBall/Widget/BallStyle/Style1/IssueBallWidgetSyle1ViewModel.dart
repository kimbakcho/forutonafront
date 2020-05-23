import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/ID001/Dto/ID001ResultPopDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';

import 'BallStyle1WidgetController.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier {
  final BuildContext _context;

  IssueBallDescriptionDto fBallDescriptionBasic;

  final BallStyle1WidgetController ballStyle1WidgetController;
  //Loading
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IssueBallWidgetSyle1ViewModel(this.ballStyle1WidgetController, this._context) {
    this.fBallDescriptionBasic = IssueBallDescriptionDto.fromJson(
        json.decode(getBallResDto().description));
  }

  bool isAliveBall() {
    return getBallResDto().activationTime.isAfter(DateTime.now());
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
    var currentUser = await FirebaseAuth.instance.currentUser();
    var fBallTypeRepository = FBallTypeRepository.create(getBallResDto().ballType);
    fBallTypeRepository.ballHit(FBallReqDto(getBallResDto().ballType,getBallResDto().ballUuid));
    if(currentUser != null){
      fBallTypeRepository.joinBall(FBallJoinReqDto(getBallResDto().ballType,getBallResDto().ballUuid,currentUser.uid));
    }

    await Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => ID001MainPage(getBallResDto().ballUuid,fBallResDto: getBallResDto())));
    this.ballStyle1WidgetController.onRequestReFreshBall(getBallResDto());
  }

  String getBallName(){
    if(getBallResDto().ballDeleteFlag){
      return "(삭제됨)${getBallResDto().ballName}";
    }else {
      return getBallResDto().ballName;
    }
  }

  String getPlaceAddress(){
    if(getBallResDto().ballDeleteFlag){
      return "";
    }else {
      return getBallResDto().ballName;
    }
  }

  String getDistanceDisplayText(){
    if(getBallResDto().ballDeleteFlag){
      return "";
    }else {
      return getBallResDto().distanceDisplayText;
    }
  }

  String getProfilePicktureUrl(){
    if(getBallResDto().ballDeleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return getBallResDto().profilePicktureUrl;
    }
  }

  String getNickName(){
    if(getBallResDto().ballDeleteFlag){
      return "";
    }else {
      return getBallResDto().nickName;
    }
  }

  String getRemainingTime(){
    if(getBallResDto().ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getRemainingToStrFromNow(
          this.getBallResDto().activationTime);
    }
  }

  String getCommentCount(){
    if(getBallResDto().ballDeleteFlag){
      return "-";
    }else {
      return this.getBallResDto().commentCount.toString();
    }
  }

  String getDisLikeCount(){
    if(getBallResDto().ballDeleteFlag){
      return "-";
    }else {
      return this.getBallResDto().ballDisLikes.toString();
    }
  }

  String getLikeCount(){
    if(getBallResDto().ballDeleteFlag){
      return "-";
    }else {
      return this.getBallResDto().ballLikes.toString();
    }
  }

  FBallResDto getBallResDto(){
    return ballStyle1WidgetController.fBallResDto;
  }
}
