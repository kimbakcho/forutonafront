
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../Preference.dart';

part 'FBall.g.dart';

@JsonSerializable(explicitToJson: true)
class FBall {
  double latitude;
  double longitude;
  String ballUuid;
  String ballName;
  FBallType ballType;
  FBallState ballState;
  String placeAddress;
  int ballHits;
  int ballLikes;
  int ballDisLikes;
  int commentCount;
  int ballPower;
  DateTime activationTime;
  DateTime makeTime;
  String description;
  String nickName;
  String profilePictureUrl;
  FUserInfoSimple uid;
  double userLevel;
  int contributor;
  bool ballDeleteFlag;


  FBall();

  factory FBall.fromJson(Map<String, dynamic> json) =>
      _$FBallFromJson(json);

  Map<String, dynamic> toJson() => _$FBallToJson(this);

  Future<void> ballHit() async {
    FBallRepository _fBallRepository = sl();
     ballHits = await _fBallRepository.ballHit(ballUuid);
  }

  Future<void> ballUpdate(FBallUpdateReqDto reqDto) async {
    FBallRepository _fBallRepository = sl();
    var fBallResDto = await _fBallRepository.updateBall(reqDto);
    longitude = fBallResDto.longitude;
    latitude = fBallResDto.latitude;
    ballName = fBallResDto.ballName;
    ballType = fBallResDto.ballType;
    placeAddress = fBallResDto.placeAddress;
    description = fBallResDto.description;
  }

  Future<void> delete() async{
    FBallRepository _fBallRepository = sl();
    await _fBallRepository.deleteBall(ballUuid);
    ballDeleteFlag =true;
    description = "{}";
  }

  bool isAliveBall(){
    return activationTime.isAfter(DateTime.now());
  }
  bool isDeadBall(){
    return activationTime.isBefore(DateTime.now());
  }

  Future<bool> isCanModify() async {
    FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter = sl();
    var firebaseUserUid = await fireBaseAuthBaseAdapter.userUid();
    if(ballUuid == firebaseUserUid){
      return true;
    }else {
      return false;
    }
  }

  String getDisplayBallName() {
    if(ballDeleteFlag){
      return "(삭제됨)"+ ballName ;
    }else {
      return ballName;
    }
  }

  String getDisplayPlaceAddress() {
    if(ballDeleteFlag){
      return "";
    }else {
      return placeAddress;
    }
  }

  String getDisplayBallHits(){
    if(ballDeleteFlag){
      return "-";
    }else {
      return NomalValueDisplay.changeIntDisplaystr(ballHits);
    }
  }

  String getDisplayProfilePictureUrl() {
    if(ballDeleteFlag){
      Preference _preference = sl();
      return _preference.basicProfileImageUrl;
    }else {
      return profilePictureUrl;
    }
  }

  String getDisplayNickName(){
    if(ballDeleteFlag){
      return "";
    }else {
      return uid.nickName;
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
      return TimeDisplayUtil.getCalcToStrFromNow(makeTime);
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

  String getDisplayFollower() {
    if(ballDeleteFlag){
      return "-";
    }else {
      return "${uid.followCount}";
    }
  }

  String getDisplayMakerInfluencePower() {
    if(ballDeleteFlag){
      return "-";
    }else {
      return "${uid.cumulativeInfluence.toStringAsFixed(0)}";
    }
  }

}
