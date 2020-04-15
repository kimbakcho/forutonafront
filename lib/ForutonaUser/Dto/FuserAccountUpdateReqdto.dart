
import 'package:json_annotation/json_annotation.dart';

part 'FuserAccountUpdateReqdto.g.dart';

@JsonSerializable()
class FuserAccountUpdateReqdto {
  String isoCode;
  String nickName;
  String selfIntroduction;

  FuserAccountUpdateReqdto(this.isoCode, this.nickName, this.selfIntroduction);

  factory FuserAccountUpdateReqdto.fromJson(Map<String, dynamic> json) => _$FuserAccountUpdateReqdtoFromJson(json);
  Map<String, dynamic> toJson() => _$FuserAccountUpdateReqdtoToJson(this);
}