import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserMakeBallList/UserMakeBallList.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileComponent.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

class G001MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G001MainPageViewModel(sl(), sl()),
        child: Consumer<G001MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  child: SingleChildScrollView(
                      child: Column(children: [
            UserProfileComponent(
              userProfileComponentViewModelController:
                  model._userProfileComponentViewModelController,
              userUid: model.userUid,
              userProfileMode: UserProfileMode.ME,
            ),
            SizedBox(
              height: 16,
            ),
            UserMakeBallList(
              userUid: model.userUid,
            )
          ]))));
        }));
  }
}

class G001MainPageViewModel extends ChangeNotifier {
  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  UserProfileComponentViewModelController
      _userProfileComponentViewModelController;

  G001MainPageViewModelController _g001mainPageViewModelController;

  G001MainPageViewModel(this._signInUserInfoUseCaseInputPort,
      this._g001mainPageViewModelController) {
    _userProfileComponentViewModelController =
        UserProfileComponentViewModelController();
    if (_g001mainPageViewModelController != null) {
      _g001mainPageViewModelController._g001mainPageViewModel = this;
    }
  }

  String get userUid {
    if (_signInUserInfoUseCaseInputPort.isLogin) {
      var reqSignInUserInfoFromMemory =
          this._signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      return reqSignInUserInfoFromMemory.uid;
    } else {
      return "";
    }
  }
}

@lazySingleton
class G001MainPageViewModelController {
  G001MainPageViewModel _g001mainPageViewModel;

  reloadUserProfile() {
    _g001mainPageViewModel._userProfileComponentViewModelController
        .reloadUserInfo();
  }
}
