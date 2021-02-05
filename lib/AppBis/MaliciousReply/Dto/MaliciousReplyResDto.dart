import 'package:json_annotation/json_annotation.dart';

part 'MaliciousReplyResDto.g.dart';

@JsonSerializable()
class MaliciousReplyResDto {
   int idx;
   String replyUuid;
   int crime;
   int abuse;
   int privacy;
   int sexual;
   int advertising;
   int etc;
   int totalNumberReports;
   bool maliciousContentFlag;
   bool falseReportFlag;
   DateTime judgmentTime;

   static MaliciousReplyResDto fromJson(Map<String, dynamic> json) => _$MaliciousReplyResDtoFromJson(json);

   Map<String, dynamic> toJson() => _$MaliciousReplyResDtoToJson(this);
}