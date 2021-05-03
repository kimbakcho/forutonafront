import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart' as Location;
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart' as Adapter;

abstract class LocationAdapter {
  Future<Adapter.PermissionStatus> hasPermission();

  Future<Adapter.PermissionStatus> requestPermission();

  Future<bool> serviceEnabled();

  Future<bool> requestService();

}

@LazySingleton(as: LocationAdapter)
class LocationAdapterImpl implements LocationAdapter {
  Location.Location? location;
  LocationAdapterImpl(){
    location = new Location.Location();
  }



  @override
  Future<Adapter.PermissionStatus>  hasPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return changeAdapterPermissionStatusStatue(permission);
  }

  @override
  Future<Adapter.PermissionStatus> requestPermission()async {
    //Release 모드에서 Location Lib 의 requestPermissions API에 문제가 있는것으로 확인
    var permissionStatus = await Geolocator.requestPermission();
    return changeAdapterPermissionStatusStatue(permissionStatus);
  }

  Adapter.PermissionStatus changeAdapterPermissionStatusStatue(LocationPermission status) {
    if(status == LocationPermission.whileInUse){
      return  Adapter.PermissionStatus.whileInUse;
    } else if(status == LocationPermission.denied){
      return  Adapter.PermissionStatus.denied;
    }else if(status == LocationPermission.deniedForever){
      return  Adapter.PermissionStatus.deniedForever;
    }else if(status == LocationPermission.always){
      return  Adapter.PermissionStatus.always;
    } else {
      throw Exception("don't Support PermissionStatus Type ");
    }
  }

  @override
  Future<bool> serviceEnabled() async {
    return await location!.serviceEnabled();
  }

  @override
  Future<bool> requestService() async{
    return await location!.requestService();
  }


}