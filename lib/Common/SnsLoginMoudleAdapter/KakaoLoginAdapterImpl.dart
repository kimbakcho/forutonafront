import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'SnsLoginModuleAdapter.dart';

class KakaoLoginAdapterImpl implements SnsLoginModuleAdapter {
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
          userNickName: user.kakaoAccount.profile.nickname,
          email: user.kakaoAccount.email,
          userProfileImageUrl: user.kakaoAccount.profile.profileImageUrl.toString());
    } catch (ex) {
      throw ex;
    }
  }

  @override
  SnsSupportService snsSupportService = SnsSupportService.Kakao;

  @override
  Future<void> logout() async {
    UserApi _userApi = UserApi.instance;
    await _userApi.logout();
    await AccessTokenStore.instance.clear();
  }
}
