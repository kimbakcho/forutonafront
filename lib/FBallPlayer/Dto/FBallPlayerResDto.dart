
import 'package:forutonafront/FBall/Domain/Value/FBallPlayState.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallPlayerResDto.g.dart';

@JsonSerializable()
class FBallPlayerResDto {
   int idx;
   FBallResDto ballUuid;
   FUserInfoSimpleResDto playerUid;
   bool hasLike;
   bool hasDisLike;
   bool hasGiveUp;
   bool hasExit;
   DateTime startTime;
   FBallPlayState playState;

   FBallPlayerResDto();

   static FBallPlayerResDto fromJson(Map<String, dynamic> json) => _$FBallPlayerResDtoFromJson(json);

   Map<String, dynamic> toJson() => _$FBallPlayerResDtoToJson(this);


}