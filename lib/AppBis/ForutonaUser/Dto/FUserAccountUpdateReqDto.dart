
import 'package:forutonafront/Components/GenderSelectComponent/GenderType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserAccountUpdateReqDto.g.dart';

@JsonSerializable()
class FUserAccountUpdateReqDto {
  String? isoCode;
  String? nickName;
  String? selfIntroduction;
  GenderType? gender;
  bool? profileImageIsEmpty;
  bool? backGroundIsEmpty;

  FUserAccountUpdateReqDto();

  factory FUserAccountUpdateReqDto.fromJson(Map<String, dynamic> json) => _$FUserAccountUpdateReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserAccountUpdateReqDtoToJson(this);
}