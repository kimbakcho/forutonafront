

import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBall.g.dart';

@JsonSerializable(explicitToJson: true)
class FBall {
  double? latitude;
  double? longitude;
  String? ballUuid;
  String? ballName;
  FBallType? ballType;
  FBallState? ballState;
  String? placeAddress;
  int? ballHits;
  int? ballLikes;
  int? ballDisLikes;
  int? commentCount;
  int? ballPower;
  DateTime? activationTime;
  DateTime? makeTime;
  String? description;
  String? nickName;
  String? profilePictureUrl;
  FUserInfoSimple? uid;
  double? userLevel;
  int? contributor;
  bool? ballDeleteFlag;

  FBall();

  factory FBall.fromJson(Map<String, dynamic> json) =>
      _$FBallFromJson(json);

  Map<String, dynamic> toJson() => _$FBallToJson(this);


}
