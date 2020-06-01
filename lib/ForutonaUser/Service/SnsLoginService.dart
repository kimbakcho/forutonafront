import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

abstract class SnsLoginService {

  FUserRepository _fUserRepository = new FUserRepository();

  SnsSupportService getSupportSnsService();

  String getToken();

  Future<bool> tryLogin();

  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto accessToken);

  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto) async{
    FUserInfoJoinResDto resDto = await _fUserRepository.joinUser(reqDto);
    AuthResult authResult = await FirebaseAuth.instance.signInWithCustomToken(token: resDto.customToken);
    return resDto;
  }

}