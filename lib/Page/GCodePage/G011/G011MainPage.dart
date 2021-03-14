import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Page/GCodePage/Component/GCodeLineButtonComponent.dart';
import 'package:forutonafront/Page/GCodePage/G012/G012MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'package:provider/provider.dart';

class G011MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G011MainPageViewModel(sl()),
        child: Consumer<G011MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  CodeAppBar(title: "설정", visibleTailButton: false,progressValue: 0),
                  GCodeLineButtonComponent(
                    icon: Icon(Icons.vpn_key),
                    text: "패스워드 재설정",
                    onTap: (){
                      model.moveToReSettingPw(context);
                    },
                  )
                ],
              ),
            ),
          );
        }));
  }
}

class G011MainPageViewModel extends ChangeNotifier {

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  G011MainPageViewModel(this._signInUserInfoUseCaseInputPort);

  moveToReSettingPw(BuildContext context){
    var fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    if(fUserInfo.snsService == SnsSupportService.Forutona){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return G012MainPage();
      }));
    }else {
      Fluttertoast.showToast(msg: "Forutona로 가입한 계정이 아닙니다.");
    }
  }



}
