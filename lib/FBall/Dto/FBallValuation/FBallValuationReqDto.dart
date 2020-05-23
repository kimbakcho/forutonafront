

import 'package:json_annotation/json_annotation.dart';

part 'FBallValuationReqDto.g.dart';

@JsonSerializable()
class FBallValuationReqDto {

  FBallValuationReqDto();

  String ballUuid;
  String uid;

  factory FBallValuationReqDto.fromJson(Map<String, dynamic> json) => _$FBallValuationReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallValuationReqDtoToJson(this);

}