import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/Page/ZCodePage/Z004/Z004CodeMainPage.dart';
import 'package:forutonafront/Page/ZCodePage/Z005/Z005CodeMainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InitPageViewModel(sl(), sl(), context),
      child: Consumer<InitPageViewModel>(
        builder: (_, model, child) {
          return Container();
        },
      ),
    );
  }
}

class InitPageViewModel extends ChangeNotifier {
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;

  final LocationAdapter locationAdapter;

  final BuildContext context;

  InitPageViewModel(this.geoLocationUtilForeGroundUseCaseInputPort,
      this.locationAdapter, this.context) {
    init();
  }

  void init() async {
    try {
      await locationAdapter.hasPermission();
    } on Exception {
      await Future.delayed(Duration(milliseconds: 200));
      init();
      return;
    }
    var hasPermission = await locationAdapter.hasPermission();
    var positionServiceEnabled =  await locationAdapter.serviceEnabled();
    if (hasPermission != PermissionStatus.whileInUse) {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) {
        return Z004CodeMainPage();
      }));
    } else if (!positionServiceEnabled){
      await locationAdapter.requestService();
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    } else {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    }
  }
}
