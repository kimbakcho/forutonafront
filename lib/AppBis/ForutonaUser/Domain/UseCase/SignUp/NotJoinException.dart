import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnSJoinReqDto.dart';

class NotJoinException implements Exception {
  String cause;
  FUserSnSJoinReqDto fUserSnSLoginReqDto;
  NotJoinException(this.cause,this.fUserSnSLoginReqDto);
}