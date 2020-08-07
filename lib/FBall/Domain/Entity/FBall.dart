
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


}
