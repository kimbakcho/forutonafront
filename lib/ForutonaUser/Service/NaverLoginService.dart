import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

import 'NotJoinException.dart';
import 'SnsLoginService.dart';

class NaverLoginService extends SnsLoginService {

  FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
  FUserRepository _fUserRepository = FUserRepository();

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async {
    FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return fUserSnsCheckJoinResDto;
  }

  @override
  Future<bool> tryLogin() async {
    NaverLoginResult naverLoginResult = await FlutterNaverLogin.logIn();
    switch(naverLoginResult.status) {
      case NaverLoginStatus.loggedIn:
        var currentAccessToken =  await FlutterNaverLogin.currentAccessToken;
        _reqDto.accessToken = currentAccessToken.accessToken;
        _reqDto.snsService = SnsSupportService.Naver;
        _reqDto.fUserUid = "${SnsSupportService.Naver}${naverLoginResult.account.id}";
        _reqDto.snsUid = naverLoginResult.account.id;
        var fUserSnsCheckJoinResDto = await snsUidJoinCheck(_reqDto);
        if(!fUserSnsCheckJoinResDto.join){
          throw new NotJoinException("not Join",fUserSnsCheckJoinResDto);
        }else {
          await FirebaseAuth.instance.signInWithCustomToken(token: fUserSnsCheckJoinResDto.firebaseCustomToken);
        }
        break;
      case NaverLoginStatus.cancelledByUser:
        throw ("cancelledByUser");
        break;
      case NaverLoginStatus.error:
        throw (naverLoginResult.errorMessage);
        break;
    }
    return true;
  }

  @override
  SnsSupportService getSupportSnsService() {
    return SnsSupportService.Naver;
  }
  @override
  String getToken() {
    return _reqDto.accessToken;
  }
}