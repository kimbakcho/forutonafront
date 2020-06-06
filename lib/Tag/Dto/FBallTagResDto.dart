import 'package:json_annotation/json_annotation.dart';

part 'FBallTagResDto.g.dart';

@JsonSerializable()
class FBallTagResDto {
  String ballUuid;
  String tagItem;

  FBallTagResDto();

  factory FBallTagResDto.fromJson(Map<String, dynamic> json) => _$FBallTagResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagResDtoToJson(this);
}