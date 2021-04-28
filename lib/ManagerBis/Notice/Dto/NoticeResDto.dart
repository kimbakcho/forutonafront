
import 'package:forutonafront/ManagerBis/MUserInfo/Dto/MUserInfoResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NoticeResDto.g.dart';

@JsonSerializable()
class NoticeResDto {
  int? idx;
  String? title;
  String? content;
  String? openFlag;

  MUserInfoResDto? writerUid;

  DateTime? modifyDate;

  static NoticeResDto fromJson(Map<String, dynamic> json) => _$NoticeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeResDtoToJson(this);
}