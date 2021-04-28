
import 'package:json_annotation/json_annotation.dart';

part 'FullChargePayLoadDto.g.dart';

@JsonSerializable()
class FullChargePayLoadDto {
  String? userNickName;
  String? userUid;
  FullChargePayLoadDto();

  factory FullChargePayLoadDto.fromJson(Map<String, dynamic> json) => _$FullChargePayLoadDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FullChargePayLoadDtoToJson(this);
}