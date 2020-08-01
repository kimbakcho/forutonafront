
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinResDto.g.dart';

@JsonSerializable()

class FUserInfoJoinResDto {
  String customToken;
  bool joinComplete;

  FUserInfoJoinResDto();


  factory FUserInfoJoinResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinResDtoToJson(this);

}