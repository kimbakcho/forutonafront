import 'package:forutonafront/FBall/Dto/FBallState.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FBall.g.dart';

@JsonSerializable()
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
  String profilePicktureUrl;
  String uid;
  double userLevel;
  double distanceWithMapCenter;
  String distanceDisplayText;
  int contributor;
  bool ballDeleteFlag;


  FBall(
      this.latitude,
      this.longitude,
      this.ballUuid,
      this.ballName,
      this.ballType,
      this.ballState,
      this.placeAddress,
      this.ballLikes,
      this.ballDisLikes,
      this.commentCount,
      this.ballPower,
      this.activationTime,
      this.makeTime,
      this.description,
      this.nickName,
      this.profilePicktureUrl,
      this.uid,
      this.userLevel,
      this.distanceWithMapCenter,
      this.distanceDisplayText,
      this.contributor,
      this.ballDeleteFlag
      );

  factory FBall.fromJson(Map<String, dynamic> json) =>
      _$FBallFromJson(json);

  Map<String, dynamic> toJson() => _$FBallToJson(this);
}
