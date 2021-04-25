import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';

import 'SignInUserInfoUseCaseOutputPort.dart';

//전체 에서 Global 하게 사용할것 이므로 싱클톤으로 Di 주입 받아 사용한다.
abstract class SignInUserInfoUseCaseInputPort {
  Stream<FUserInfoResDto> fUserInfoStream;
  FUserInfoResDto reqSignInUserInfoFromMemory({SignInUserInfoUseCaseOutputPort outputPort});
  Future<FUserInfoResDto> saveSignInInfoInMemoryFromAPiServer({SignInUserInfoUseCaseOutputPort outputPort});
  void clearUserInfo();
  bool isLogin;
  Future<bool> isLoginFromPreference();
  checkMaliciousPopup();
}
