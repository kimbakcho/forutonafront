import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

abstract class SingUpUseCaseInputPort {
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto reqDto);
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto);
}