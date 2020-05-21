
import 'package:json_annotation/json_annotation.dart';

import '../FBallType.dart';

part 'UserBallResDto.g.dart';

@JsonSerializable()
class UserBallResDto {
  @JsonKey(name: "fballUuid")
  String fBallUuid;
  @JsonKey(name: "fballType")
  FBallType fBallType;
  double longitude;
  double latitude;
  String ballName;
  String ballPlaceAddress;
  //ball의 Like
  int ballLikes;
  //ball의 DisLike
  int ballDisLikes;
  int commentCount;
  DateTime activationTime;
  DateTime makeTime;
  bool ballDeleteFlag;

  double distanceWithMapCenter;
  String distanceDisplayText;

  UserBallResDto();

  factory UserBallResDto.fromJson(Map<String, dynamic> json) => _$UserBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserBallResDtoToJson(this);
}