import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoinReq.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

import 'SingUpUseCaseInputPort.dart';

class SingUpUseCase implements SingUpUseCaseInputPort {
  FUserRepository _fUserRepository;

  FUserInfoJoinReq fUserInfoJoinReq = FUserInfoJoinReq();

  SingUpUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async {
    var fUserSnsCheckJoin = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return FUserSnsCheckJoinResDto.fromFUserSnsCheckJoin(fUserSnsCheckJoin);
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto) async {
    var fUserInfoJoin = await _fUserRepository.joinUser(reqDto);
   return FUserInfoJoinResDto.fromFUserInfoJoin(fUserInfoJoin);
  }

  @override
  void setEmail(String email) {
    fUserInfoJoinReq.email = email;
  }

  @override
  void setSnsToken(String snsToken) {
    fUserInfoJoinReq.snsToken = snsToken;
  }

  @override
  void setSupportSnsService(SnsSupportService supportSnsService) {
    fUserInfoJoinReq.snsSupportService = supportSnsService;
  }

  @override
  void setNickName(String nickName) {
    fUserInfoJoinReq.nickName = nickName;
  }

  @override
  void setUserProfileImageUrl(String userProfileImageUrl) {
    fUserInfoJoinReq.userProfileImageUrl = userProfileImageUrl;
  }

  @override
  void setAgeLimitAgree(bool ageOverAgree) {
    fUserInfoJoinReq.ageLimitAgree = ageOverAgree;
  }

  @override
  void setCountryCode(String countryCode) {
    fUserInfoJoinReq.countryCode = countryCode;
  }

  @override
  void setForutonaAgree(bool forutonaAgree) {
    fUserInfoJoinReq.forutonaAgree = forutonaAgree;
  }

  @override
  void setForutonaManagementAgree(bool forutonaManagementAgree) {
    fUserInfoJoinReq.forutonaManagementAgree = forutonaManagementAgree;
  }

  @override
  void setMartketingAgree(bool martketingAgree) {
    fUserInfoJoinReq.martketingAgree = martketingAgree;
  }

  @override
  void setPositionAgree(bool positionAgree){
    fUserInfoJoinReq.positionAgree = positionAgree;
  }

  @override
  void setPrivateAgree(bool privateAgree) {
    fUserInfoJoinReq.privateAgree = privateAgree;
  }

  @override
  void setInternationalizedPhoneNumber(String internationalizedPhoneNumber) {
    fUserInfoJoinReq.internationalizedPhoneNumber = internationalizedPhoneNumber;
  }

  @override
  void setPhoneAuthToken(String phoneAuthToken) {
    fUserInfoJoinReq.phoneAuthToken = phoneAuthToken;
  }

  @override
  SnsSupportService getSnsSupportService() {
    return fUserInfoJoinReq.snsSupportService;
  }

  @override
  void setPassword(String pw) {
    fUserInfoJoinReq.password = pw;
  }



}
