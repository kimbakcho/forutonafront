import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoinReq.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

abstract class SingUpUseCaseInputPort {
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto);
  Future<FUserInfoJoinResDto> joinUser();

  void setNickName(String userNickName);
  void setEmail(String email);
  void setUserProfileImageUrl(String userProfileImageUrl);
  void setSupportSnsService(SnsSupportService snsSupportService);
  void setSnsToken(String accessToken);
  void setForutonaAgree(bool forutonaAgree);
  void setForutonaManagementAgree(bool forutonaManagementAgree);
  void setMartketingAgree(bool martketingAgree);
  void setPositionAgree(bool positionAgree);
  void setPrivateAgree(bool privateAgree);
  void setAgeLimitAgree(bool ageOverAgree);
  void setCountryCode(String countryCode);
  SnsSupportService getSnsSupportService();
  void setInternationalizedPhoneNumber(String internationalizedPhoneNumber);
  void setPhoneAuthToken(String phoneAuthToken);
  void setPassword(String pw);
  void setUserIntroduce(String userIntroduce);
  String getCountryCode();
  String getUserProfileImageUrl();
  String getNickName();

}