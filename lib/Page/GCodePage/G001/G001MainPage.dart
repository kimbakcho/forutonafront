import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G001MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G001MainPageViewModel(
            context: context,
            signInUserInfoUseCaseInputPort: sl(),
            fireBaseAuthAdapterForUseCase: sl(),
            logoutUseCaseInputPort: sl()),
        child: Consumer<G001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    padding: MediaQuery.of(context).padding,
                    child: Column(
                      children: [
                        model._userInfoResDto!= null? userProfileImage(model) : Container(),
                        model._userInfoResDto!= null? userNickName(model): Container(),
                        model._userInfoResDto!= null? userCountry(model): Container(),
                        model._userInfoResDto!= null?  userIntroduce(model): Container(),
                        Row(
                          children: [
                            FlatButton(
                                onPressed: () {
                                  model._logoutTry();
                                },
                                child: Text("로그아웃"))
                          ],
                        )
                      ],
                    )))
          ]);
        }));
  }

  Row userIntroduce(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: model.haveUserSelfIntroduction()
                ? Text(model.getUserSelfIntroduction(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Color(0xff454F63),
                    ))
                : Container(
                    child: InkWell(
                        onTap: () {},
                        child: Text(model.getUserSelfIntroduction(),
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: Color(0xff3497fd),
                              decoration: TextDecoration.underline,
                            ))))),
      ],
    );
  }

  Row userCountry(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(model.getUserCountry(),
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xff454f63),
              )),
        ),
      ],
    );
  }

  Row userNickName(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: Text(model.getUserNickName(),
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff454f63),
                ))),
      ],
    );
  }

  Row userProfileImage(G001MainPageViewModel model) {
    if(model._userInfoResDto != null && model._userInfoResDto.profilePictureUrl != null){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 69.00,
              width: 69.00,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: model.getUserProfileImage(),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  shape: BoxShape.circle)),
        ],
      );
    }else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 69.00,
              width: 69.00,
              child: SvgPicture.asset("assets/IconImage/user-circle.svg")),
        ],
      );
    }


  }
}

class G001MainPageViewModel extends ChangeNotifier
    implements SignInUserInfoUseCaseOutputPort {
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final BuildContext context;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  final LogoutUseCaseInputPort logoutUseCaseInputPort;

  CodeCountry _countryCode = new CodeCountry();

  FUserInfoResDto _userInfoResDto;

  bool isLoading = false;

  StreamSubscription<FUserInfoResDto> _fUserInfoStreamSubscription;

  G001MainPageViewModel(
      {@required this.context,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required this.logoutUseCaseInputPort})
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

  Future<void> _logoutTry() async{
    await logoutUseCaseInputPort.tryLogout();
    Navigator.of(context).pop();
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
