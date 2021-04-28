import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'SnsLoginModuleAdapter.dart';

class KakaoLoginAdapterImpl implements SnsLoginModuleAdapter {

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  KakaoLoginAdapterImpl(this._fireBaseAuthAdapterForUseCase);

  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    try {
      final installed = await isKakaoTalkInstalled();
      final authCode = installed
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(authCode);
      await AccessTokenStore.instance.toStore(token);
      User user = await UserApi.instance.me();
      return SnsLoginModuleResDto(user.id.toString(), token.accessToken,
          userNickName: user.kakaoAccount!.profile!.nickname,
          email: user.kakaoAccount!.email,
          userProfileImageUrl: user.kakaoAccount!.profile!.profileImageUrl.toString());
    } catch (ex) {
      throw ex;
    }
  }

  @override
  SnsSupportService? snsSupportService = SnsSupportService.Kakao;

  @override
  Future<void> logout() async {
    UserApi _userApi = UserApi.instance;
    await _userApi.logout();
    await AccessTokenStore.instance.clear();
  }

  @override
  Future<void> login(FUserSnsCheckJoinResDto? fUserSnsCheckJoinResDto) async {
    await _fireBaseAuthAdapterForUseCase
        .signInWithCustomToken(fUserSnsCheckJoinResDto!.firebaseCustomToken!);
  }
}
