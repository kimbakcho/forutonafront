import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/Value/FUserInfoJoinReq.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Preference.dart';
import 'package:injectable/injectable.dart';

import 'SingUpUseCaseInputPort.dart';
@Injectable(as: SingUpUseCaseInputPort)
class SingUpUseCase implements SingUpUseCaseInputPort {
  FUserRepository _fUserRepository;
  Preference _preference;
  FUserInfoJoinReq fUserInfoJoinReq;
  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  SingUpUseCase(
      {@required
          FUserRepository fUserRepository,
      @required
          Preference preference,
        FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fUserRepository = fUserRepository,
        _preference = preference,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase{
    fUserInfoJoinReq = FUserInfoJoinReq(preference: _preference);
  }

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(
      SnsSupportService snsService, String accessToken) async {
    FUserSnsCheckJoinResDto fUserSnsCheckJoin =
        await _fUserRepository.getSnsUserJoinCheckInfo(snsService,accessToken);
    return fUserSnsCheckJoin;
  }

  @override
  Future<FUserInfoJoinResDto> joinUser() async {
    await _fireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(fUserInfoJoinReq.email,fUserInfoJoinReq.password);
    fUserInfoJoinReq.clearPassword();
    FUserInfoJoinResDto fUserInfoJoinResDto = await _fUserRepository.joinUser(FUserInfoJoinReqDto.fromFUserInfoJoinReq(fUserInfoJoinReq));
    await _fireBaseAuthAdapterForUseCase.signInWithCustomToken(fUserInfoJoinResDto.customToken);
    return fUserInfoJoinResDto;
  }

  @override
  void setEmail(String email) {
    fUserInfoJoinReq.emailUserUid = email;
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
  void setPositionAgree(bool positionAgree) {
    fUserInfoJoinReq.positionAgree = positionAgree;
  }

  @override
  void setPrivateAgree(bool privateAgree) {
    fUserInfoJoinReq.privateAgree = privateAgree;
  }

  @override
  void setInternationalizedPhoneNumber(String internationalizedPhoneNumber) {
    fUserInfoJoinReq.internationalizedPhoneNumber =
        internationalizedPhoneNumber;
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

  @override
  void setUserIntroduce(String userIntroduce) {
    fUserInfoJoinReq.userIntroduce = userIntroduce;
  }

  @override
  String getCountryCode() {
    return fUserInfoJoinReq.countryCode;
  }

  @override
  String getUserProfileImageUrl() {
    return fUserInfoJoinReq.userProfileImageUrl;
  }

  @override
  String getNickName() {
    return fUserInfoJoinReq.nickName;
  }
}
