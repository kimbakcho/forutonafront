import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

import 'SnsLoginService.dart';

class FaceBookLoginService implements SnsLoginService{

  FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
  FUserRepository _fUserRepository = FUserRepository();

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async{
    FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return fUserSnsCheckJoinResDto;
  }

  @override
  tryLogin() async {
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
          throw("not join User");
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        throw("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        throw(result.errorMessage);
        break;
    }
    return null;

  }

}