import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

import '../SnsLoginService.dart';
import 'NotJoinException.dart';

class FaceBookLoginService extends SnsLoginService{

  FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
  FUserRepository _fUserRepository = FUserRepository();


  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async{
    FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return fUserSnsCheckJoinResDto;
  }

  @override
  Future<bool> tryLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _reqDto.accessToken = result.accessToken.token;
        _reqDto.snsService = SnsSupportService.FaceBook;
        _reqDto.fUserUid  = "${SnsSupportService.FaceBook}${result.accessToken.userId}";
        _reqDto.snsUid = result.accessToken.userId;
        var fUserSnsCheckJoinResDto = await snsUidJoinCheck(_reqDto);
        if(!fUserSnsCheckJoinResDto.join){
          throw new NotJoinException("not Join",fUserSnsCheckJoinResDto);
        }else {
          await FirebaseAuth.instance.signInWithCustomToken(token: fUserSnsCheckJoinResDto.firebaseCustomToken);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        throw(result.errorMessage);
        break;
    }
    return true;
  }

  @override
  SnsSupportService getSupportSnsService() {
    return SnsSupportService.FaceBook;
  }

  @override
  String getToken() {
    return _reqDto.accessToken;
  }

}