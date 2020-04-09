import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';

enum HCodeState { HCDOE, ICODE, JCODE, KCODE, LCODE }

class CodeMainViewModel with ChangeNotifier {
  PageController pageController;
  HCodeState currentState;
  Geolocator _geoLocator = new Geolocator();
  Position lastKnownPosition;
  GeolocationRepository _geolocationRepository = new GeolocationRepository();
  String firstAddress = "";
  CodeMainViewModel() {
    pageController = new PageController();
    currentState = HCodeState.HCDOE;
    init();
  }
  init()async {
    this.lastKnownPosition = await _geoLocator.getLastKnownPosition();
    _geoLocator.getPositionStream().listen(changeGeolocationListen);
    firstAddress = await _geolocationRepository.getCurrentPhoneAddress();
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
        pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
        pageController.jumpToPage(3);
        break;
      case HCodeState.LCODE:
        pageController.jumpToPage(4);
        break;
    }
    notifyListeners();
  }
}
