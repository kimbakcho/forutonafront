
import 'package:json_annotation/json_annotation.dart';

part 'MaliciousBallReqDto.g.dart';

@JsonSerializable()
class MaliciousBallReqDto {
  String? ballUuid;
  int? crime;
  int? abuse;
  int? privacy;
  int? sexual;
  int? advertising;
  int? etc;
  int? totalNumberReports;
  bool? maliciousContentFlag;
  bool? falseReportFlag;
  DateTime? judgmentTime;
  static MaliciousBallReqDto fromJson(Map<String, dynamic> json) => _$MaliciousBallReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MaliciousBallReqDtoToJson(this);
}