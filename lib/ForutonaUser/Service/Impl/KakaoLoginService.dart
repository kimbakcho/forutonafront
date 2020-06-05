import 'package:firebase_auth/firebase_auth.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'NotJoinException.dart';
import '../SnsLoginService.dart';

class KakaoLoginService extends SnsLoginService {

  FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
  FUserRepository _fUserRepository = FUserRepository();

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async{
    FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return fUserSnsCheckJoinResDto;
  }

  @override
  Future<bool>  tryLogin() async {
    try {
      final installed = await isKakaoTalkInstalled();
      final authCode = installed ? await AuthCodeClient.instance.requestWithTalk() : await AuthCodeClient.instance.request();
        AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
        await AccessTokenStore.instance.toStore(token);
      User user = await UserApi.instance.me();
        _reqDto.accessToken = token.accessToken;
        _reqDto.snsService = SnsSupportService.Kakao;
        _reqDto.fUserUid  = "${SnsSupportService.Kakao}${user.id}";
        _reqDto.snsUid = user.id.toString();
        var fUserSnsCheckJoinResDto = await snsUidJoinCheck(_reqDto);
        if(!fUserSnsCheckJoinResDto.join){
          throw new NotJoinException("not Join",fUserSnsCheckJoinResDto);
        }else {
          await FirebaseAuth.instance.signInWithCustomToken(token: fUserSnsCheckJoinResDto.firebaseCustomToken);
        }
    } on KakaoAuthException catch (e) {
      throw(e.message);
    } on KakaoClientException catch (e) {
      throw(e.message);
    } catch (e) {
      throw(e.message);
    }
    return true;
  }

  @override
  SnsSupportService getSupportSnsService() {
    return SnsSupportService.Kakao;
  }
  @override
  String getToken() {
    return _reqDto.accessToken;
  }
}