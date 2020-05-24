import 'package:json_annotation/json_annotation.dart';
import 'UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
part 'UserToMakerBallResDto.g.dart';

@JsonSerializable()
class UserToMakerBallResDto extends UserBallResDto {

  factory UserToMakerBallResDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallResDtoToJson(this);

  UserToMakerBallResDto() : super();

}