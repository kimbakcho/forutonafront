import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';

class G001MainPageViewModel extends ChangeNotifier
    implements SignInUserInfoUseCaseOutputPort {
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final BuildContext context;

  CodeCountry _countryCode = new CodeCountry();

  FUserInfo _userInfo;

  G001MainPageViewModel(
      {@required this.context,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required AuthUserCaseInputPort authUserCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _authUserCaseInputPort = authUserCaseInputPort {
    _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory(outputPort: this);
    getUserInfoBackEndApi();
  }

  ImageProvider getUserProfileImage() {
    return NetworkImage(_userInfo.profilePictureUrl);
  }

  String getUserNickName() {
    return _userInfo.nickName;
  }

  String getUserCountry() {
    return _countryCode.findCountryName(_userInfo.isoCode);
  }

  String getUserSelfIntroduction() {
    return _userInfo.selfIntroduction;
  }

  bool haveUserSelfIntroduction() {
    if (_userInfo.selfIntroduction == null ||
        _userInfo.selfIntroduction.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onSignInUserInfoFromMemory(FUserInfo fUserInfo) async {
    _userInfo = fUserInfo;
  }

  void getUserInfoBackEndApi() async {
    _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer(
        await _authUserCaseInputPort.myUid(),outputPort: this);
  }
}
