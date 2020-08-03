import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBall.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IssueBall.g.dart';


@JsonSerializable(explicitToJson: true)
class IssueBall extends FBall{



  IssueBall(){
    ballType = FBallType.IssueBall;
    _issueBallDescription = new IssueBallDescription();
  }

  @JsonKey(ignore: true)
  IssueBallDescription _issueBallDescription;

  factory IssueBall.fromFBallResDto(FBallResDto resDto){
    IssueBall issueBall = IssueBall.fromJson(resDto.toJson());
    issueBall._issueBallDescription = IssueBallDescription.fromJson(json.decode(resDto.description));
    return issueBall;
  }
  factory IssueBall.fromJson(Map<String, dynamic> json) =>
      _$IssueBallFromJson(json);

  Map<String, dynamic> toJson() => _$IssueBallToJson(this);

  get description {
    return json.encode(_issueBallDescription.toJson());
  }

  bool isMainPicture(){
    return _issueBallDescription.isMainPicture();
  }

  String mainPictureSrc(){
    return _issueBallDescription.mainPictureSrc();
  }

  int pictureCount(){
    return _issueBallDescription.pictureCount();
  }


  List<FBallDesImages> getDesImages() {
    return this._issueBallDescription.desimages;
  }

  setDesImages(List<FBallDesImages> desImages){
    if(desImages == null){
      this._issueBallDescription.desimages = [];
    }else {
      this._issueBallDescription.desimages = desImages;
    }
  }

  String getDisplayDescriptionText() {
    if(ballDeleteFlag){
      return "삭제됨";
    }else {
      return _issueBallDescription.text;
    }
  }


  setDescriptionText(String value) {
    this._issueBallDescription.text = value;
  }

  Future<bool> isCanModify() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(ballUuid == firebaseUser.uid){
      return true;
    }else {
      return false;
    }
  }

  bool hasYoutubeVideo(){
    return _issueBallDescription.hasYoutubeVideo();
  }

  String getDisplayYoutubeVideoId() {
    return _issueBallDescription.youtubeVideoId;
  }

  setYoutubeVideoId(String value) {
    _issueBallDescription.youtubeVideoId = value;
  }

  plusBallLike(int point){
    this.ballLikes += point.abs();
  }
  minusBallLike(int point){
    this.ballLikes -= point.abs();
  }
  plusBallDisLike(int point){
    this.ballDisLikes += point.abs();
  }
  minusBallDisLike(int point){
    this.ballDisLikes -= point.abs();
  }

  minusContributorCount(){
    this.contributor--;
  }


  isUserBall({@required String myUid}){
    return uid != myUid;
  }

  void reFreshFromBallResDto(FBallResDto fBallResDto) {
    latitude = fBallResDto.latitude;
     longitude = fBallResDto.longitude;
     ballUuid = fBallResDto.ballUuid;
     ballName = fBallResDto.ballName;
     ballType = fBallResDto.ballType;
     ballState = fBallResDto.ballState;
     placeAddress = fBallResDto.placeAddress;
     ballHits = fBallResDto.ballHits;
     ballLikes = fBallResDto.ballLikes;
     ballDisLikes= fBallResDto.ballDisLikes;
     commentCount = fBallResDto.commentCount;
     ballPower = fBallResDto.ballPower ;
     activationTime = fBallResDto.activationTime ;
     makeTime = fBallResDto.makeTime ;
     description = fBallResDto.description;
     nickName  = fBallResDto.nickName;
     profilePictureUrl = fBallResDto.profilePictureUrl;
     uid  = FUserInfoSimple.fromFUserInfoSimpleResDto(fBallResDto.uid);
     userLevel = fBallResDto.userLevel;
     contributor  = fBallResDto.contributor;
     ballDeleteFlag = fBallResDto.ballDeleteFlag;
    _issueBallDescription = IssueBallDescription.fromJson(json.decode(fBallResDto.description));
  }

}