import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:injectable/injectable.dart';

import 'SnsLoginModuleAdapter.dart';

@named
@Injectable(as: SnsLoginModuleAdapter)
class NaverLoginAdapterImpl implements SnsLoginModuleAdapter {
  @override
  // ignore: missing_return
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    NaverLoginResult neverLoginResult;
    try {
      neverLoginResult = await FlutterNaverLogin.logIn();
    } catch (ex) {
      throw ex;
    }
    switch (neverLoginResult.status) {
      case NaverLoginStatus.loggedIn:
        var currentAccessToken = await FlutterNaverLogin.currentAccessToken;
        return SnsLoginModuleResDto(
            neverLoginResult.account.id, currentAccessToken.accessToken,
            userNickName: neverLoginResult.account.nickname,
            email: neverLoginResult.account.email,
            userProfileImageUrl: neverLoginResult.account.profileImage);
      case NaverLoginStatus.cancelledByUser:
        throw ("cancelledByUser");
        break;
      case NaverLoginStatus.error:
        throw (neverLoginResult.errorMessage);
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
