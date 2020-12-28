import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';

import 'SnsLoginModuleAdapter.dart';


class FaceBookLoginAdapterImpl implements SnsLoginModuleAdapter{

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  FaceBookLoginAdapterImpl(this._fireBaseAuthAdapterForUseCase);

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

  @override
  Future<void> login(FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto)  async {
    await _fireBaseAuthAdapterForUseCase
        .signInWithCustomToken(fUserSnsCheckJoinResDto.firebaseCustomToken);
  }

}