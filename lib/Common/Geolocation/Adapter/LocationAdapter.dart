import 'package:location/location.dart' as Location;
import 'package:forutonafront/Common/Geolocation/Data/Value/PermissionStatus.dart' as Adapter;

abstract class LocationAdapter {
  Future<Adapter.PermissionStatus> hasPermission();

  Future<Adapter.PermissionStatus> requestPermission();

  Future<bool> serviceEnabled();

  Future<bool> requestService();

}
class LocationAdapterImpl implements LocationAdapter {
  Location.Location location = new Location.Location();

  @override
  Future<Adapter.PermissionStatus>  hasPermission() async {
    return changeAdapterPermissionStatusStatue(await location.hasPermission());
  }

  @override
  Future<Adapter.PermissionStatus> requestPermission()async {
    Location.PermissionStatus status = await location.requestPermission();
    return changeAdapterPermissionStatusStatue(status);
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
  serviceEnabled() async {
    return await location.serviceEnabled();
  }

  @override
  requestService() async{
    return await location.requestService();
  }

}