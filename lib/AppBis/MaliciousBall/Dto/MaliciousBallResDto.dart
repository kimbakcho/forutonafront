
import 'package:forutonafront/ManagerBis/MUserInfo/Dto/MUserInfoResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MaliciousBallResDto.g.dart';

@JsonSerializable()
class MaliciousBallResDto {
  int idx;
  String ballUuid;
  int totalNumberReports;
  int crime;
  int abuse;
  int privacy;
  int sexual;
  int advertising;
  int etc;
  bool maliciousContentFlag;
  bool falseReportFlag;
  DateTime judgmentTime;
  MUserInfoResDto judgmentUid;

  static MaliciousBallResDto fromJson(Map<String, dynamic> json) => _$MaliciousBallResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MaliciousBallResDtoToJson(this);
}