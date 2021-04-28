import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/Page/LCodePage/L002/L002MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:injectable/injectable.dart';

import 'SingUpUseCaseInputPort.dart';
@LazySingleton(as: SingUpUseCaseInputPort)
class SingUpUseCase implements SingUpUseCaseInputPort {
  FUserRepository _fUserRepository;

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  SnsLoginModuleAdapterFactory snsLoginModuleAdapterFactory;

  FUserInfoJoinReqDto fUserInfoJoinReqDto;

  SingUpUseCase(
      {required
          FUserRepository fUserRepository,
        required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,required this.snsLoginModuleAdapterFactory,required this.fUserInfoJoinReqDto})
      : _fUserRepository = fUserRepository,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(
      SnsSupportService? snsService, String? accessToken) async {
    FUserSnsCheckJoinResDto fUserSnsCheckJoin =
        await _fUserRepository.getSnsUserJoinCheckInfo(snsService!,accessToken!);
    return fUserSnsCheckJoin;
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto fUserInfoJoinReqDto,List<int>? profileImage,List<int>? backgroundImage) async {
    FUserInfoJoinResDto fUserInfoJoinResDto = await _fUserRepository.joinUser(fUserInfoJoinReqDto,profileImage,backgroundImage);
    await _fireBaseAuthAdapterForUseCase.signInWithCustomToken(fUserInfoJoinResDto.customToken!);
    return fUserInfoJoinResDto;
  }


  trySignSns(SnsSupportService snsSupportService,BuildContext context) async {
    fUserInfoJoinReqDto.snsSupportService = snsSupportService;

    var instance = snsLoginModuleAdapterFactory.getInstance(
        snsSupportService);

    LoginUseCaseInputPort loginUseCaseInputPort = LoginUseCase(singUpUseCaseInputPort: sl(),
        snsLoginModuleAdapter: instance, signInUserInfoUseCaseInputPort: null);

    var snsLoginModuleResDto = await instance.getSnsModuleUserInfo();
    var fUserSnsCheckJoinResDto = await snsUidJoinCheck(snsSupportService, snsLoginModuleResDto!.accessToken);

    if (fUserSnsCheckJoinResDto.join) {
      await loginUseCaseInputPort.tryLogin();
      Navigator.of(context).pop();
    } else {
      fUserInfoJoinReqDto.email = fUserSnsCheckJoinResDto.email;
      fUserInfoJoinReqDto.nickName = fUserSnsCheckJoinResDto.userSnsName;
      fUserInfoJoinReqDto.profileImageUrl = fUserSnsCheckJoinResDto.pictureUrl;
      fUserInfoJoinReqDto.countryCode = "KR";
      fUserInfoJoinReqDto.snsToken = snsLoginModuleResDto.accessToken;
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) {
            return L002MainPage();
          }));
    }
  }

}
