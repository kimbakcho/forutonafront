import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';

abstract class UserPasswordChangeUseCaseInputPort {
  Future<int> pwChange(FUserInfoPwChangeReqDto reqDto);
}