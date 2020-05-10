import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

import 'SnsLoginService.dart';

class ForutonaLoginService extends SnsLoginService {
  FUserRepository _fUserRepository = FUserRepository();

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto) async{

    AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: reqDto.email, password: reqDto.password);
    reqDto.emailUserUid = authResult.user.uid;
    FUserInfoJoinResDto resDto = await _fUserRepository.joinUser(reqDto);

    return resDto;
  }

  @override
  SnsSupportService getSupportSnsService() {
    return SnsSupportService.Forutona;
  }
}