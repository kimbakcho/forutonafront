
import 'package:json_annotation/json_annotation.dart';

part 'MaliciousReplyReqDto.g.dart';

@JsonSerializable()
class MaliciousReplyReqDto {
  String replyUuid;
  int crime;
  int abuse;
  int privacy;
  int sexual;
  int advertising;
  int etc;

  static MaliciousReplyReqDto fromJson(Map<String, dynamic> json) => _$MaliciousReplyReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MaliciousReplyReqDtoToJson(this);
}