import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';

abstract class SignInUserInfoUseCaseOutputPort {
  void onSignInUserInfoFromMemory(FUserInfo fUserInfo);
}