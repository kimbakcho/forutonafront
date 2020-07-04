
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinReq.g.dart';

@JsonSerializable()
class FUserInfoJoinReq {
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
  String internationalizedPhoneNumber;
  //해당 토큰으로 최종 가입 절차에서 인증 받은 폰인지 체크한다.
  String phoneAuthToken;
  String password;
  String emailUserUid;

  FUserInfoJoinReq();

  factory FUserInfoJoinReq.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinReqFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinReqToJson(this);
}