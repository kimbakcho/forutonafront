import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

class NotJoinException implements Exception {
  String cause;
  FUserSnsCheckJoinResDto snsCheckJoinResDto;
  NotJoinException(this.cause,this.snsCheckJoinResDto);
}