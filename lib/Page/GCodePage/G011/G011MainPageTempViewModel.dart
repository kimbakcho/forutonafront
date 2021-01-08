import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Page/GCodePage/G012/G012MainPageTemp.dart';

class G011MainPageTempViewModel extends ChangeNotifier {
  final BuildContext context;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  G011MainPageTempViewModel(
      {@required this.context,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort}):
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;

  void onBackBtnTap() {
    Navigator.of(context).pop();
  }

  void goResetPwPage() async {

    var fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    if (fUserInfo.snsService == SnsSupportService.Kakao) {
      Fluttertoast.showToast(
          msg: "Kakao 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }
    if (fUserInfo.snsService == SnsSupportService.Naver) {
      Fluttertoast.showToast(
          msg: "Naver 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }
    if (fUserInfo.snsService == SnsSupportService.FaceBook) {
      Fluttertoast.showToast(
          msg: "Facebook 계정에서 변경해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return;
    }

    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => G012MainPageTemp(),settings: RouteSettings(name: "/G012")));

  }
}
