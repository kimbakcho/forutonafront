import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';

abstract class UserInfoUpdateUseCaeInputPort {
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto);

}