import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

abstract class FBallListUpFromMapAreaUseCaseOutputPort {
 void onBallListUpFromMapArea(List<FBallResDto> resDtos, LatLng northeastLat , LatLng southwestLat);
}