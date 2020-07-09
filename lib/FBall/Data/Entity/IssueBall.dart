import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Data/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IssueBall.g.dart';


@JsonSerializable()
class IssueBall extends FBall{

  Preference _preference = sl();

  IssueBall(){
    ballType = FBallType.IssueBall;
    _issueBallDescription = new IssueBallDescription();
  }

  @JsonKey(ignore: true)
  List<FBallTag> tags = [];
  @JsonKey(ignore: true)
  IssueBallDescription _issueBallDescription;

  factory IssueBall.fromFBallResDto(FBallResDto resDto){
    IssueBall issueBall = IssueBall.fromJson(resDto.toJson());
    issueBall._issueBallDescription = IssueBallDescription.fromJson(json.decode(resDto.description));
    return issueBall;
  }

  get description {
    return json.encode(_issueBallDescription.toJson());
  }

  factory IssueBall.fromJson(Map<String, dynamic> json) =>
      _$IssueBallFromJson(json);

  Map<String, dynamic> toJson() => _$IssueBallToJson(this);

  bool isAliveBall(){
    return activationTime.isAfter(DateTime.now());
  }
  bool isDeadBall(){
    return activationTime.isBefore(DateTime.now());
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

  String getDisplayBallName() {
    if(ballDeleteFlag){
      return "(삭제됨)${super.ballName}";
    }else {
      return ballName;
    }
  }

  String getDisplayPlaceAddress() {
    if(ballDeleteFlag){
      return "";
    }else {
      return super.placeAddress;
    }
  }

  String getDisplayProfilePictureUrl() {
    if(ballDeleteFlag){
      return _preference.basicProfileImageUrl;
    }else {
      return super.profilePictureUrl;
    }
  }

  String getDisplayNickName(){
    if(ballDeleteFlag){
      return "";
    }else {
      return super.nickName;
    }
  }

  String getDisplayRemainingTime() {
    if(ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(activationTime);
    }
  }

  String getDisplayMakeTime() {
    if(ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(super.makeTime);
    }
  }

  String getDisplayCommentCount (){
    if(ballDeleteFlag){
      return "-";
    }else {
      return commentCount.toString();
    }
  }

  String getDisplayDisLikeCount() {
    if(ballDeleteFlag){
      return "-";
    }else {
      return ballDisLikes.toString();
    }
  }

  String getDisplayLikeCount(){
    if(ballDeleteFlag){
      return "-";
    }else {
      return ballLikes.toString();
    }
  }

  ballHit(){
    ballHits++;
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

  bool hasTags() {
    if(tags.length == 0){
      return false;
    }else {
      return true;
    }
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
     uid  = fBallResDto.uid;
     userLevel = fBallResDto.userLevel;
     contributor  = fBallResDto.contributor;
     ballDeleteFlag = fBallResDto.ballDeleteFlag;
    _issueBallDescription = IssueBallDescription.fromJson(json.decode(fBallResDto.description));
  }

}