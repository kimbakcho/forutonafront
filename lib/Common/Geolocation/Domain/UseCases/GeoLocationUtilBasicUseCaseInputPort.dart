import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';



abstract class GeoLocationUtilBasicUseCaseInputPort {
  Future<Position> getCurrentWithLastPosition();
  Future<Position> getLastKnowPonePosition();
  Future<String> getPositionAddress(Position searchPosition);
  String replacePlacemarkToAddresStr(Placemark placemark);
  Position getCurrentWithLastPositionInMemory();
  String getCurrentWithLastAddressInMemory();
  Stream<Position> getUserPositionStream();
  startStreamCurrentPosition();
}
