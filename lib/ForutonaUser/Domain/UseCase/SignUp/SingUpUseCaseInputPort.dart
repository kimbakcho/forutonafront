import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';

abstract class SingUpUseCaseInputPort {
  Future<FUserSnsCheckJoin> snsUidJoinCheck(FUserSnSLoginReqDto reqDto);
}