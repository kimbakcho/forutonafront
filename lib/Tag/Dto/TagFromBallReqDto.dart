
import 'package:json_annotation/json_annotation.dart';

part 'TagFromBallReqDto.g.dart';

@JsonSerializable()
class TagFromBallReqDto {
  String ballUuid;

  TagFromBallReqDto({this.ballUuid});

  factory TagFromBallReqDto.fromJson(Map<String, dynamic> json) => _$TagFromBallReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagFromBallReqDtoToJson(this);
}