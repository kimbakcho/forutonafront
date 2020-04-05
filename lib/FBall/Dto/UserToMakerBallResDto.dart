import 'package:json_annotation/json_annotation.dart';

import 'FBallType.dart';
import 'UserBallResDto.dart';

part 'UserToMakerBallResDto.g.dart';

@JsonSerializable()
class UserToMakerBallResDto extends UserBallResDto {


  factory UserToMakerBallResDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallResDtoToJson(this);

  UserToMakerBallResDto() : super('', null, 0.0, 0.0, '', '', 0, 0, 0, null, null, 0.0, '');

}