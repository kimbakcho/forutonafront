
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Value/FUserInfoJoinReq.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';

abstract class SingUpUseCaseInputPort {
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(SnsSupportService snsService, String accessToken);
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReq fUserInfoJoinReq);

}