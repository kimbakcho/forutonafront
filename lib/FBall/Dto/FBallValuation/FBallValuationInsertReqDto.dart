import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallValuationInsertReqDto.g.dart';

@JsonSerializable()
class FBallValuationInsertReqDto {
  String valueUuid;
  String ballUuid;
  String uid;
  int upAndDown;

  FBallValuationInsertReqDto(
      {@required this.valueUuid,
      @required this.ballUuid,
      @required this.uid,
      @required this.upAndDown});

  factory FBallValuationInsertReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallValuationInsertReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallValuationInsertReqDtoToJson(this);
}
