import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTagResDto.g.dart';

@JsonSerializable()
class FBallTagResDto {
  int idx;
  String tagItem;
  FBallResDto ballUuid;

  FBallTagResDto();

  factory FBallTagResDto.fromJson(Map<String, dynamic> json) => _$FBallTagResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagResDtoToJson(this);


}