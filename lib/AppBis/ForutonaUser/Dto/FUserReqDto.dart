
import 'package:json_annotation/json_annotation.dart';

part 'FUserReqDto.g.dart';

@JsonSerializable()
class FUserReqDto {
  String uid;


  FUserReqDto(this.uid);

  factory FUserReqDto.fromJson(Map<String, dynamic> json) => _$FUserReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserReqDtoToJson(this);
}