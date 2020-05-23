
import 'package:json_annotation/json_annotation.dart';

part 'FBallValuationInsertReqDto.g.dart';

@JsonSerializable()
class FBallValuationInsertReqDto {
  FBallValuationInsertReqDto();
  String valueUuid;
  String ballUuid;
  String uid;
  int unAndDown;

  factory FBallValuationInsertReqDto.fromJson(Map<String, dynamic> json) => _$FBallValuationInsertReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallValuationInsertReqDtoToJson(this);
}
