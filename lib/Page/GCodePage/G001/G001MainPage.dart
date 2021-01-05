import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserMakeBallList/UserMakeBallList.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileComponent.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class G001MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G001MainPageViewModel(sl()),
        child: Consumer<G001MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserProfileComponent(
                      userUid: model.userUid,
                      userProfileMode: UserProfileMode.ME,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    UserMakeBallList(
                      //Todo 추후에 model.userUid 변경 지금은 테스트용 ID
                      userUid: "h2q2jl3nRPXZ8809Uvi9KdzSss83",
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class G001MainPageViewModel extends ChangeNotifier {
  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  G001MainPageViewModel(this._signInUserInfoUseCaseInputPort);

  String get userUid {
    var reqSignInUserInfoFromMemory =
        this._signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    return reqSignInUserInfoFromMemory.uid;
  }
}
