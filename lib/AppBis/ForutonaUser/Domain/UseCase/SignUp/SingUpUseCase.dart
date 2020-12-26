import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'package:injectable/injectable.dart';

import 'SingUpUseCaseInputPort.dart';
@LazySingleton(as: SingUpUseCaseInputPort)
class SingUpUseCase implements SingUpUseCaseInputPort {
  FUserRepository _fUserRepository;

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  SingUpUseCase(
      {@required
          FUserRepository fUserRepository,

        FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fUserRepository = fUserRepository,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(
      SnsSupportService snsService, String accessToken) async {
    FUserSnsCheckJoinResDto fUserSnsCheckJoin =
        await _fUserRepository.getSnsUserJoinCheckInfo(snsService,accessToken);
    return fUserSnsCheckJoin;
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto fUserInfoJoinReqDto,List<int> profileImage,List<int> backgroundImage) async {
    var userUid = await _fireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(fUserInfoJoinReqDto.email,fUserInfoJoinReqDto.password);
    fUserInfoJoinReqDto.emailUserUid = userUid;
    FUserInfoJoinResDto fUserInfoJoinResDto = await _fUserRepository.joinUser(fUserInfoJoinReqDto,profileImage,backgroundImage);
    await _fireBaseAuthAdapterForUseCase.signInWithCustomToken(fUserInfoJoinResDto.customToken);
    return fUserInfoJoinResDto;
  }


}
