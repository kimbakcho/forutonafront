import 'package:json_annotation/json_annotation.dart';

part 'MUserInfoResDto.g.dart';

@JsonSerializable()
class MUserInfoResDto {
  String uid;
  String userUuid;
  String userName;
  String groupName;
  String hasRole;

  MUserInfoResDto();

  factory MUserInfoResDto.fromJson(Map<String, dynamic> json) => _$MUserInfoResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MUserInfoResDtoToJson(this);
}