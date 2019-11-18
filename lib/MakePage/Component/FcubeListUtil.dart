import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:geolocator/geolocator.dart';

class FcubeListUtil {
  List<FcubeExtender1> cubeList = List<FcubeExtender1>();
  bool isLoading = false;
  Future<void> updatecubedistancewithme(Position position) async {
    for (int i = 0; i < cubeList.length; i++) {
      cubeList[i].distancewithme = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          cubeList[i].latitude,
          cubeList[i].longitude);
    }
    return;
  }
}
