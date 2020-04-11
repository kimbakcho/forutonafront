

import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class GeolocationRepository {



  Future<String> getPositionAddress(Position reqPosition) async {
    String resultAddress = "";
    if (reqPosition != null) {
      var placeMarkList = await Geolocator()
          .placemarkFromPosition(reqPosition, localeIdentifier: "ko");
      if (placeMarkList.length > 0) {
        resultAddress = "";

        if (placeMarkList[0].administrativeArea != null &&
            placeMarkList[0].administrativeArea.length != 0) {
          resultAddress += placeMarkList[0].administrativeArea;
          if (placeMarkList[0].subLocality != null &&
              placeMarkList[0].subLocality.length != 0) {
            resultAddress += (" " + placeMarkList[0].subLocality);
            if (placeMarkList[0].thoroughfare != null &&
                placeMarkList[0].thoroughfare.length != 0) {
              resultAddress += (" " + placeMarkList[0].thoroughfare);
              if (placeMarkList[0].subThoroughfare != null &&
                  placeMarkList[0].subThoroughfare.length != 0) {
                resultAddress += (" " + placeMarkList[0].subThoroughfare);
              }
            }
          }
        } else {
          resultAddress = "";
        }
      } else {
        resultAddress = "";
      }
    }
    if(resultAddress.length == 0){
      return "주 소 없 음";
    }else {
      return resultAddress;
    }
  }

}
