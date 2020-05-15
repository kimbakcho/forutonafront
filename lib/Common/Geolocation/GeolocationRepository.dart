import 'package:geolocator/geolocator.dart';

import 'GeoLocationUtil.dart';

class GeolocationRepository {

  Future<String> getPositionAddress(Position reqPosition) async {
    String resultAddress = "";
    GeoLocationUtil _geoLocationUtil =new GeoLocationUtil();
    if (reqPosition != null) {
      var placeMarkList = await Geolocator()
          .placemarkFromPosition(reqPosition, localeIdentifier: "ko");
      if (placeMarkList.length > 0) {
        resultAddress = _geoLocationUtil.replacePlacemarkToAddresStr(placeMarkList[0]);
      } else {
        resultAddress = "";
      }
    }
    if (resultAddress.length == 0) {
      return "주 소 없 음";
    } else {
      return resultAddress;
    }
  }
}
