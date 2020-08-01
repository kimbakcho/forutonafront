import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';

abstract class SignInUserInfoUseCaseOutputPort {
  void onSignInUserInfoFromMemory(FUserInfoResDto fUserInfo);
}