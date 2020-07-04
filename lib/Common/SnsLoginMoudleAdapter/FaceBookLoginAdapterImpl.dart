import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'SnsLoginModuleAdapter.dart';

class FaceBookLoginAdapterImpl implements SnsLoginModuleAdapter{

  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return SnsLoginModuleResDto(result.accessToken.userId, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        throw(result.errorMessage);
        break;
    }
  }

  @override
  SnsSupportService snsSupportService = SnsSupportService.FaceBook;

}