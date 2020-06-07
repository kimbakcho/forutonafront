import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Data/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IssueBall.g.dart';


@JsonSerializable()
class IssueBall extends FBall{

  IssueBall(){
    ballType = FBallType.IssueBall;
  }
  List<FBallTag> tags;
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

  String get ballName {
    if(ballDeleteFlag){
      return "(삭제됨)${super.ballName}";
    }else {
      return ballName;
    }
  }

  String get placeAddress {
    if(ballDeleteFlag){
      return "";
    }else {
      return super.placeAddress;
    }
  }

  String get profilePictureUrl {
    if(ballDeleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return super.profilePictureUrl;
    }
  }

  String get nickName{
    if(ballDeleteFlag){
      return "";
    }else {
      return super.nickName;
    }
  }

  String get remainingTime {
    if(ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(activationTime);
    }
  }

  String get displayMakeTime {
    if(ballDeleteFlag){
      return "-";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(super.makeTime);
    }
  }

  String get displayCommentCount{
    if(ballDeleteFlag){
      return "-";
    }else {
      return commentCount.toString();
    }
  }

  get displayDisLikeCount {
    if(ballDeleteFlag){
      return "-";
    }else {
      return ballDisLikes.toString();
    }
  }

  get displayLikeCount{
    if(ballDeleteFlag){
      return "-";
    }else {
      return ballLikes.toString();
    }
  }

  ballHit(){
    ballHits++;
  }

  List<FBallDesImages> get desImages {
    return this._issueBallDescription.desimages;
  }

  set desImages(List<FBallDesImages> desImages){
    this._issueBallDescription.desimages = desImages;
  }

  get descriptionText {
    if(ballDeleteFlag){
      return "삭제됨";
    }else {
      return _issueBallDescription.text;
    }
  }
  set descriptionText(String value) {
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

  get youtubeVideoId {
    return _issueBallDescription.youtubeVideoId;
  }
  set youtubeVideoId(String value) {
    _issueBallDescription.youtubeVideoId = value;
  }

  plusBallLike(int point){
    this.ballLikes += point;
  }
  minusBallLike(int point){
    this.ballLikes -= point;
  }
  plusBallDisLike(int point){
    this.ballDisLikes += point;
  }
  minusBallDisLike(int point){
    this.ballDisLikes -= point;
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

}