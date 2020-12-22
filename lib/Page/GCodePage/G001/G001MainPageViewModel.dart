import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class G001MainPageViewModel extends ChangeNotifier
    implements SignInUserInfoUseCaseOutputPort {
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final BuildContext context;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  CodeCountry _countryCode = new CodeCountry();

  FUserInfoResDto _userInfoResDto;

  bool isLoading = false;

  StreamSubscription<FUserInfoResDto> _fUserInfoStreamSubscription;

  G001MainPageViewModel(
      {@required this.context,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase {
    try {
      _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory(
          outputPort: this);
    } catch (ex) {
      isLoading = true;
    } finally {
      getUserInfoBackEndApi();
    }
    _fUserInfoStreamSubscription = _signInUserInfoUseCaseInputPort
        .fUserInfoStream
        .listen(onSignInUserInfoFromMemory);
  }

  ImageProvider getUserProfileImage() {
    return NetworkImage(_userInfoResDto.profilePictureUrl);
  }

  String getUserNickName() {
    return _userInfoResDto.nickName;
  }

  String getUserCountry() {
    return _countryCode.findCountryName(_userInfoResDto.isoCode);
  }

  String getUserSelfIntroduction() {
    return _userInfoResDto.selfIntroduction;
  }

  bool haveUserSelfIntroduction() {
    if (_userInfoResDto.selfIntroduction == null ||
        _userInfoResDto.selfIntroduction.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _fUserInfoStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void onSignInUserInfoFromMemory(FUserInfoResDto fUserInfo) async {
    _userInfoResDto = fUserInfo;
    isLoading = false;
    notifyListeners();
  }

  void getUserInfoBackEndApi() async {
    _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer(
        await _fireBaseAuthAdapterForUseCase.userUid(),
        outputPort: this);
  }
}
