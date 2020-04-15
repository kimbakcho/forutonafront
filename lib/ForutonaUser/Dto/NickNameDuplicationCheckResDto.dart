
import 'package:json_annotation/json_annotation.dart';

part 'NickNameDuplicationCheckResDto.g.dart';

@JsonSerializable()
class NickNameDuplicationCheckResDto {
  bool haveNickName;

  NickNameDuplicationCheckResDto(this.haveNickName);
  factory NickNameDuplicationCheckResDto.fromJson(Map<String, dynamic> json) => _$NickNameDuplicationCheckResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NickNameDuplicationCheckResDtoToJson(this);
}