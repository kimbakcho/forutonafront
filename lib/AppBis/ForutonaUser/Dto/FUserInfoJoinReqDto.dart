
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Components/GenderSelectComponent/GenderType.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinReqDto.g.dart';

@JsonSerializable()
@lazySingleton
class FUserInfoJoinReqDto {

  bool forutonaAgree;
  bool forutonaManagementAgree;
  bool privateAgree;
  bool positionAgree;
  bool martketingAgree;
  bool ageLimitAgree;
  String nickName;
  String email;
  SnsSupportService snsSupportService;
  String countryCode;
  String snsToken;
  String userIntroduce;
  String internationalizedPhoneNumber;
  //해당 토큰으로 최종 가입 절차에서 인증 받은 폰인지 체크한다.
  String phoneAuthToken;
  String password;
  String emailUserUid;
  DateTime ageDate;
  GenderType gender;

  String profileImageUrl;

  factory FUserInfoJoinReqDto.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinReqDtoToJson(this);

  FUserInfoJoinReqDto();

}