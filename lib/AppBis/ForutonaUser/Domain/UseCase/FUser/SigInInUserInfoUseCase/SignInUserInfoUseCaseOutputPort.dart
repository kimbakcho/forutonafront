import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';

abstract class SignInUserInfoUseCaseOutputPort {
  void onSignInUserInfoFromMemory(FUserInfoResDto fUserInfo);
}