import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
enum HCodeState { HCDOE, ICODE, BCODE, KCODE, GCODE  }

class CodeMainViewModel with ChangeNotifier {
  PageController pageController;
  HCodeState currentState;

  Position lastKnownPosition;

  String firstAddress = "";
  BuildContext _context;

  CodeMainViewModel(this._context) {
    pageController = new PageController();
    currentState = HCodeState.HCDOE;
    init();
  }

  init()async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white, animate: true);
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    await GeoLocationUtilUseCase().useGpsReq(_context);
    this.lastKnownPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    var placeMarkList = await Geolocator()
        .placemarkFromPosition(lastKnownPosition, localeIdentifier: "ko");
    firstAddress = GeoLocationUtilUseCase().replacePlacemarkToAddresStr(placeMarkList[0]);
  }

  changeGeolocationListen(Position currentPosition){
    lastKnownPosition = currentPosition;
  }

  jumpToPage(HCodeState pageCode) {
    currentState = pageCode;
    switch (currentState) {
      case HCodeState.HCDOE:
        pageController.jumpToPage(0);
        break;
      case HCodeState.ICODE:
        pageController.jumpToPage(1);
        break;
      case HCodeState.BCODE:
        pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
//        pageController.jumpToPage(3);
        break;
      case HCodeState.GCODE:
        pageController.jumpToPage(4);
        break;

    }
    notifyListeners();
  }
}
