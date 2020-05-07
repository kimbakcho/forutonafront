
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinReqDto.g.dart';

@JsonSerializable()

class FUserInfoJoinReqDto {

  bool forutonaAgree;
  bool forutonaManagementAgree;
  bool privateAgree;
  bool positionAgree;
  bool martketingAgree;
  bool ageLimitAgree;
  String nickName;
  String email;
  String userProfileImageUrl;
  SnsSupportService snsSupportService;
  String countryCode;
  String snsToken;
  String userIntroduce;


  FUserInfoJoinReqDto();
}