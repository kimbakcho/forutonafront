import 'package:kakao_flutter_sdk/all.dart';

import 'SnsLoginModuleAdapter.dart';

class KakaoLoginAdapterImpl implements SnsLoginModuleAdapter{
  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    try{
      final installed = await isKakaoTalkInstalled();
      final authCode = installed
          ? await AuthCodeClient.instance.requestWithTalk()
          : await AuthCodeClient.instance.request();
      AccessTokenResponse token =
      await AuthApi.instance.issueAccessToken(authCode);
      await AccessTokenStore.instance.toStore(token);
      User user = await UserApi.instance.me();
      return SnsLoginModuleResDto(user.id.toString(),token.accessToken);
    }catch(ex) {
      throw ex;
    }

  }
}