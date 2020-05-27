import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum HCodeState { HCDOE, ICODE, JCODE, KCODE, GCODE  }

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
    await GeoLocationUtil().useGpsReq(_context);
    this.lastKnownPosition = await GeoLocationUtil().getCurrentWithLastPosition();
    var placeMarkList = await Geolocator()
        .placemarkFromPosition(lastKnownPosition, localeIdentifier: "ko");
    firstAddress = GeoLocationUtil().replacePlacemarkToAddresStr(placeMarkList[0]);
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
      case HCodeState.JCODE:
//        pageController.jumpToPage(2);
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
