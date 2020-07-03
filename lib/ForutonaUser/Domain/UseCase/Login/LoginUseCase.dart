import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/NotJoinException.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

 class LoginUseCase implements LoginUseCaseInputPort {
   SingUpUseCaseInputPort _singUpUseCaseInputPort;
   SnsLoginModuleAdapter _snsLoginModuleAdapter;
   FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

   LoginUseCase(
       {@required SingUpUseCaseInputPort singUpUseCaseInputPort,
         @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
         @required SnsLoginModuleAdapter snsLoginModuleAdapter})
       : _singUpUseCaseInputPort = singUpUseCaseInputPort,
         _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
         _snsLoginModuleAdapter = snsLoginModuleAdapter;

   @override
   Future<bool> tryLogin() async {
     SnsLoginModuleResDto kakaoUserInfoResDto;
     try{
       kakaoUserInfoResDto = await _snsLoginModuleAdapter.getSnsModuleUserInfo();
     } catch (ex){
       throw ex;
     }
     FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
     _reqDto.accessToken = kakaoUserInfoResDto.accessToken;
     _reqDto.snsService = SnsSupportService.Kakao;
     _reqDto.fUserUid = "${SnsSupportService.Kakao}${kakaoUserInfoResDto.uid}";
     _reqDto.snsUid = kakaoUserInfoResDto.uid;
     var fUserSnsCheckJoin = await _singUpUseCaseInputPort.snsUidJoinCheck(_reqDto);
     if (isJoined(fUserSnsCheckJoin)) {
       throw new NotJoinException("not Join", fUserSnsCheckJoin);
     } else {
       await _fireBaseAuthAdapterForUseCase
           .signInWithCustomToken(fUserSnsCheckJoin.firebaseCustomToken);
     }
     return true;
   }

   bool isJoined(FUserSnsCheckJoinResDto fUserSnsCheckJoin) => !fUserSnsCheckJoin.join;
}
