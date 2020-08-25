import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

import 'SnsLoginModuleAdapter.dart';

class FaceBookLoginAdapterImpl implements SnsLoginModuleAdapter{

  @override
  // ignore: missing_return
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

  @override
  Future<void> logout() async {
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
  }

}