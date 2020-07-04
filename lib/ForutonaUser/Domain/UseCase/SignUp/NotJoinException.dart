import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

class NotJoinException implements Exception {
  String cause;
  FUserSnSLoginReqDto fUserSnSLoginReqDto;
  NotJoinException(this.cause,this.fUserSnSLoginReqDto);
}