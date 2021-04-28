import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserAlarmConfigUpdateReqDto.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateAccountUserInfoUseCaseInputPort {
  Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto,List<int> profileImage,List<int> backgroundImage);
  Future<FUserInfoResDto>  userAlarmConfigUpdate(UserAlarmConfigUpdateReqDto userAlarmConfigUpdateReqDto);
}

@LazySingleton(as: UpdateAccountUserInfoUseCaseInputPort)
class UpdateAccountUserInfoUseCase implements UpdateAccountUserInfoUseCaseInputPort{

  final FUserRepository _fUserRepository;
  UpdateAccountUserInfoUseCase({required FUserRepository fUserRepository}):_fUserRepository=fUserRepository;

  @override
  Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto,List<int> profileImage,List<int> backgroundImage) async {
    FUserInfoResDto fUserInfoResDto = await _fUserRepository.updateAccountUserInfo(reqDto,profileImage,backgroundImage);
    return fUserInfoResDto;
  }

  @override
  Future<FUserInfoResDto> userAlarmConfigUpdate(UserAlarmConfigUpdateReqDto userAlarmConfigUpdateReqDto) async{
    FUserInfoResDto fUserInfoResDto  = await _fUserRepository.userAlarmConfigUpdate(userAlarmConfigUpdateReqDto);
    return fUserInfoResDto;
  }





}