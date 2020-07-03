import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'SnsLoginModuleAdapter.dart';

class KakaoLoginAdapterImpl implements SnsLoginModuleAdapter{
  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    NaverLoginResult naverLoginResult;
    try{
      naverLoginResult = await FlutterNaverLogin.logIn();
    }catch(ex){
      throw ex;
    }
    switch(naverLoginResult.status) {
      case NaverLoginStatus.loggedIn:
        var currentAccessToken =  await FlutterNaverLogin.currentAccessToken;
        return SnsLoginModuleResDto(naverLoginResult.account.id, currentAccessToken.accessToken);
      case NaverLoginStatus.cancelledByUser:
        throw ("cancelledByUser");
        break;
      case NaverLoginStatus.error:
        throw (naverLoginResult.errorMessage);
        break;
    }
  }
}