import 'package:json_annotation/json_annotation.dart';

import 'FBallTagResDto.dart';

part 'FBallTagWrapDto.g.dart';

@JsonSerializable()
class FBallTagWrapDto {
  int totalCount;
  List<FBallTagResDto> tags;

  FBallTagWrapDto();

  factory FBallTagWrapDto.fromJson(Map<String, dynamic> json) => _$FBallTagWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagWrapDtoToJson(this);

}