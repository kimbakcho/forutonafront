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
   final SingUpUseCaseInputPort _singUpUseCaseInputPort;
   final SnsLoginModuleAdapter _snsLoginModuleAdapter;
   final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

   LoginUseCase(
       {@required SingUpUseCaseInputPort singUpUseCaseInputPort,
         @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
         @required SnsLoginModuleAdapter snsLoginModuleAdapter})
       : _singUpUseCaseInputPort = singUpUseCaseInputPort,
         _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
         _snsLoginModuleAdapter = snsLoginModuleAdapter;

   @override
   Future<bool> tryLogin() async {
     SnsLoginModuleResDto snsUserInfoResDto;
     try{
       snsUserInfoResDto = await _snsLoginModuleAdapter.getSnsModuleUserInfo();
     } catch (ex){
       throw ex;
     }
     FUserSnSLoginReqDto _reqDto = FUserSnSLoginReqDto();
     _reqDto.accessToken = snsUserInfoResDto.accessToken;
     _reqDto.snsService = _snsLoginModuleAdapter.snsSupportService;
     _reqDto.fUserUid = "${_reqDto.snsService}${snsUserInfoResDto.uid}";
     _reqDto.snsUid = snsUserInfoResDto.uid;
     _reqDto.userNickName = snsUserInfoResDto.userNickName;
     _reqDto.email = snsUserInfoResDto.email;
     _reqDto.userProfileImageUrl = snsUserInfoResDto.userProfileImageUrl;

     var fUserSnsCheckJoin = await _singUpUseCaseInputPort.snsUidJoinCheck(_reqDto);

     if (isNotJoin(fUserSnsCheckJoin)) {
       throw new NotJoinException("not Join", _reqDto);
     } else {
       await _fireBaseAuthAdapterForUseCase
           .signInWithCustomToken(fUserSnsCheckJoin.firebaseCustomToken);
     }

     return true;
   }

   bool isNotJoin(FUserSnsCheckJoinResDto fUserSnsCheckJoin) => !fUserSnsCheckJoin.join;

  @override
  SnsSupportService getSnsSupportService() {
    return _snsLoginModuleAdapter.snsSupportService;
  }
}
