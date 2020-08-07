import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';

abstract class UpdateAccountUserInfoUseCaseInputPort {
  Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto);
}

class UpdateAccountUserInfoUseCase implements UpdateAccountUserInfoUseCaseInputPort{

  final FUserRepository _fUserRepository;
  UpdateAccountUserInfoUseCase({@required FUserRepository fUserRepository}):_fUserRepository=fUserRepository;

  @override
  Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto) async {
    FUserInfoResDto fUserInfoResDto = await _fUserRepository.updateAccountUserInfo(reqDto);
    return fUserInfoResDto;
  }

}