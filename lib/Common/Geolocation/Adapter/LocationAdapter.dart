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
    return changeAdapterPermissionStatusStatue(await location!.hasPermission());
  }

  @override
  Future<Adapter.PermissionStatus> requestPermission()async {
    //Release 모드에서 Location Lib 의 requestPermissions API에 문제가 있는것으로 확인
    var permissionStatus = await location!.requestPermission();
    return changeAdapterPermissionStatusStatue(permissionStatus);
  }

  Adapter.PermissionStatus changeAdapterPermissionStatusStatue(Location.PermissionStatus status) {
    if(status == Location.PermissionStatus.granted){
      return  Adapter.PermissionStatus.granted;
    } else if(status == Location.PermissionStatus.denied){
      return  Adapter.PermissionStatus.denied;
    }else if(status == Location.PermissionStatus.deniedForever){
      return  Adapter.PermissionStatus.deniedForever;
    }else {
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