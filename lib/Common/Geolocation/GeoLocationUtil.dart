import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as Permit;

class GeoLocationUtil {
  ///GPS 가 사용 가능한지 알아보는 메소드
  ///만약 GPS off 면 on 요청 해줌 Flutter 권한 관련 오류로 요청 메세지를 던지기만 하고 타임 아웃으로 빠져 나옴
  static Future<void> useGpsReq() async {
    try {
      Location location = new Location();
      bool _serviceEnabled;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        await location.requestService().timeout(Duration(seconds: 1));
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          return false;
        }
      }
    } catch (Ex) {
      permissionCheck();
      return true;
    }
    return true;
  }

  static Future<bool> permissionCheck() async {
    Map<Permit.PermissionGroup, Permit.PermissionStatus> permissition =
        await Permit.PermissionHandler().requestPermissions([
      Permit.PermissionGroup.location,
      Permit.PermissionGroup.locationAlways
    ]);
    if ((permissition[Permit.PermissionGroup.locationAlways] ==
            Permit.PermissionStatus.granted) ||
        (permissition[Permit.PermissionGroup.location] ==
            Permit.PermissionStatus.granted)) {
      return true;
    } else {
      return false;
    }
  }

  static String replacePlacemarkToAddresStr(Placemark placemark) {
    String resultAddress = "";
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea.length != 0) {
      resultAddress += placemark.administrativeArea;
      if (placemark.subLocality != null && placemark.subLocality.length != 0) {
        resultAddress += (" " + placemark.subLocality);
      } else {
        resultAddress += (" " + placemark.locality);
      }

      if (placemark.thoroughfare != null &&
          placemark.thoroughfare.length != 0) {
        resultAddress += (" " + placemark.thoroughfare);
        if (placemark.subThoroughfare != null &&
            placemark.subThoroughfare.length != 0) {
          resultAddress += (" " + placemark.subThoroughfare);
        }
      }
    } else {
      resultAddress = "";
    }
    return resultAddress;
  }
}
