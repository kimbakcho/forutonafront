
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:android_intent/android_intent.dart';

class Z004CodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Z004CodeMainPageViewModel(sl(),context),
      child: Consumer<Z004CodeMainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Forutona에 오신 것을 환영 합니다."),
                          ),
                          Container(
                            child: Text("포루투나는 위치 기반 플랫폼 으로, 저희 서비스를 사용하기 위해서는 위취 접근 권한이 필요 합니다."),
                          )
                        ],
                      ),
                    ),
                  )),
                  RaisedButton(onPressed: () async {
                    await model.gotoAppDetailSettingPage();
                  }, child: Text("설정 변경")),
                  RaisedButton(onPressed: (){
                    model.reqGpsWithAppStart();
                  }, child: Text("위치 접근 동의")),
                  Container(
                    child: Text("동의후 아래 설정 버튼을 눌러 주세요"),
                  ),
                  RaisedButton(onPressed: (){
                    model.reqGpsWithAppStart();
                  }, child: Text("포루투나 입장")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Z004CodeMainPageViewModel extends ChangeNotifier {

  final GeoLocationUtilForeGroundUseCaseInputPort
  geoLocationUtilForeGroundUseCaseInputPort;

  final BuildContext context;

  Z004CodeMainPageViewModel(this.geoLocationUtilForeGroundUseCaseInputPort,this.context){
    init();
  }

  gotoAppDetailSettingPage()async {
    var _androidIntent = AndroidIntent(
      data: "package:co.kr.forutonafront",
      action: "action_application_details_settings",
    );
    await _androidIntent.launch();
  }

  reqGpsWithAppStart() async {
    var isCanUseGps = await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();
    if(isCanUseGps){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    }else {
      Fluttertoast.showToast(msg: "위치정보 접근에 동의해 주세요.");
    }
  }

  void init() async {
    var isCanUseGps = await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();
    if(isCanUseGps){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    }
  }


}
