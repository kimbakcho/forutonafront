
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../FBall/Dto/FBallResDto.dart';

part 'FBallValuationResDto.g.dart';
@JsonSerializable(explicitToJson: true)
class FBallValuationResDto {
  String valueUuid;
  FBallResDto ballUuid;
  FUserInfoSimpleResDto uid;
  int ballLike = 0;
  int ballDislike = 0;
  int point = 0;
  FBallValuationResDto();

  static FBallValuationResDto fromJson(Map<String, dynamic> json) => _$FBallValuationResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallValuationResDtoToJson(this);
}