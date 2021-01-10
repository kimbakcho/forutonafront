import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:injectable/injectable.dart';

abstract class UserInfoUseCaseInputPort {
  Future<FUserInfoSimpleResDto> getFUserInfoSimple(String userUid);
}

@LazySingleton(as: UserInfoUseCaseInputPort)
class UserInfoUseCase implements UserInfoUseCaseInputPort {

  final FUserRepository _fUserRepository;

  UserInfoUseCase(this._fUserRepository);

  @override
  Future<FUserInfoSimpleResDto> getFUserInfoSimple(String userUid) async{
    var fUserInfoSimpleResDto = await this._fUserRepository.getFUserInfoSimple(userUid);
    return fUserInfoSimpleResDto;
  }



}