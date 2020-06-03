import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
part 'UserToMakerBallResDto.g.dart';

@JsonSerializable()
class UserToMakerBallResDto extends FBallResDto {
  factory UserToMakerBallResDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallResDtoToJson(this);
  UserToMakerBallResDto() ;
}