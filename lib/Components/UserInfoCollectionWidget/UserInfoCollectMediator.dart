
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoListUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:injectable/injectable.dart';


abstract class UserInfoCollectMediator extends SearchCollectMediator<FUserInfoSimpleResDto> {

  UserInfoListUpUseCaseInputPort userInfoListUpUseCaseInputPort;

}

@Injectable(as: UserInfoCollectMediator)
class UserInfoCollectMediatorImpl extends UserInfoCollectMediator{

  @override
  UserInfoListUpUseCaseInputPort userInfoListUpUseCaseInputPort;

  UserInfoCollectMediatorImpl(){
    sort = "playerPower,DESC";
    pageLimit = 3;
  }

  @override
  bool isNullSearchUseCase() {
    if(userInfoListUpUseCaseInputPort == null){
      return true;
    }else {
      return false;
    }
  }

  @override
  Future<PageWrap<FUserInfoSimpleResDto>> searchUseCase(Pageable pageable) async {
    return await userInfoListUpUseCaseInputPort.search(pageable);
  }


}