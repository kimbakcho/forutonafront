import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

import 'SnsLoginModuleAdapter.dart';

class NaverLoginAdapterImpl implements SnsLoginModuleAdapter {
  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    NaverLoginResult naverLoginResult;
    try {
      naverLoginResult = await FlutterNaverLogin.logIn();
    } catch (ex) {
      throw ex;
    }
    switch (naverLoginResult.status) {
      case NaverLoginStatus.loggedIn:
        var currentAccessToken = await FlutterNaverLogin.currentAccessToken;
        return SnsLoginModuleResDto(
            naverLoginResult.account.id, currentAccessToken.accessToken,
            userNickName: naverLoginResult.account.nickname,
            email: naverLoginResult.account.email,
            userProfileImageUrl: naverLoginResult.account.profileImage);
      case NaverLoginStatus.cancelledByUser:
        throw ("cancelledByUser");
        break;
      case NaverLoginStatus.error:
        throw (naverLoginResult.errorMessage);
        break;
    }
  }

  @override
  SnsSupportService snsSupportService = SnsSupportService.Naver;

  @override
  Future<void> logout() async{
    await FlutterNaverLogin.logOut();
  }
}
