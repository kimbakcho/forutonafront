import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

import 'SingUpUseCaseInputPort.dart';

class SingUpUseCase implements SingUpUseCaseInputPort {
  FUserRepository _fUserRepository;

  SingUpUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto) async {
    var fUserSnsCheckJoin = await _fUserRepository.getSnsUserJoinCheckInfo(reqDto);
    return FUserSnsCheckJoinResDto.fromFUserSnsCheckJoin(fUserSnsCheckJoin);
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto) async {
    var fUserInfoJoin = await _fUserRepository.joinUser(reqDto);
   return FUserInfoJoinResDto.fromFUserInfoJoin(fUserInfoJoin);
  }


}
