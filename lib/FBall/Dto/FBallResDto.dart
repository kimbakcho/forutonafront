import 'package:json_annotation/json_annotation.dart';

import 'FBallState.dart';
import 'FBallType.dart';

part 'FBallResDto.g.dart';

@JsonSerializable()
class FBallResDto {
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
  int contributor;
  bool ballDeleteFlag;


  FBallResDto(
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
      this.contributor,
      this.ballDeleteFlag
      );

  factory FBallResDto.fromJson(Map<String, dynamic> json) =>
      _$FBallResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallResDtoToJson(this);
}
