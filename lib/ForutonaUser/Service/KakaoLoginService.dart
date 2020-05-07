import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

import 'NotJoinException.dart';
import 'SnsLoginService.dart';

class KakaoLoginService implements SnsLoginService {

  FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
  FUserRepository _fUserRepository = FUserRepository();

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async{
    FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return fUserSnsCheckJoinResDto;
  }

  @override
  Future<bool>  tryLogin() async {
    FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
    KakaoLoginResult result;
    result = await kakaoSignIn.logIn();
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        result = await kakaoSignIn.getUserMe();
        KakaoAccessToken token =await kakaoSignIn.currentAccessToken;
        _reqDto.accessToken = token.token;
        _reqDto.snsService = SnsSupportService.Kakao;
        _reqDto.fUserUid  = "${SnsSupportService.Kakao}${result.account.userID}";
        _reqDto.snsUid = result.account.userID;
        var fUserSnsCheckJoinResDto = await snsUidJoinCheck(_reqDto);
        if(!fUserSnsCheckJoinResDto.join){
          throw new NotJoinException("not Join",fUserSnsCheckJoinResDto);
        }
        break;
      case KakaoLoginStatus.loggedOut:
        throw("loggedOut");
        break;
      case KakaoLoginStatus.error:
        throw(result.errorMessage);
        break;
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