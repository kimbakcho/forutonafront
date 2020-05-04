
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinReqDto.g.dart';

@JsonSerializable()

class FUserInfoJoinReqDto {

  bool forutonaAgree;
  bool privateAgree;
  bool positionAgree;
  bool martketingAgree;
  bool ageLimitAgree;

  FUserInfoJoinReqDto();
}