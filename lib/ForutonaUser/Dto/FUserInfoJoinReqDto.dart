
import 'package:forutonafront/ForutonaUser/Domain/Value/FUserInfoJoinReq.dart';
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
  String internationalizedPhoneNumber;
  //해당 토큰으로 최종 가입 절차에서 인증 받은 폰인지 체크한다.
  String phoneAuthToken;
  String password;
  String emailUserUid;

  factory FUserInfoJoinReqDto.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinReqDtoToJson(this);

  FUserInfoJoinReqDto();

  factory FUserInfoJoinReqDto.fromFUserInfoJoinReq(FUserInfoJoinReq item){
    FUserInfoJoinReqDto reqDto = new FUserInfoJoinReqDto();
    reqDto.forutonaAgree = item.forutonaAgree;
    reqDto.forutonaManagementAgree = item.forutonaManagementAgree;
    reqDto.privateAgree = item.privateAgree;
    reqDto.positionAgree = item.positionAgree;
    reqDto.martketingAgree = item.martketingAgree;
    reqDto.ageLimitAgree = item.ageLimitAgree;
    reqDto.nickName = item.nickName;
    reqDto.email = item.email;
    reqDto.userProfileImageUrl = item.userProfileImageUrl;
    reqDto.snsSupportService = item.snsSupportService;
    reqDto.countryCode = item.countryCode;
    reqDto.snsToken = item.snsToken;
    reqDto.userIntroduce = item.userIntroduce;
    reqDto.internationalizedPhoneNumber = item.internationalizedPhoneNumber;
    reqDto.phoneAuthToken = item.phoneAuthToken;
    reqDto.password = item.password;
    reqDto.emailUserUid = item.emailUserUid;
    return reqDto;
  }
}