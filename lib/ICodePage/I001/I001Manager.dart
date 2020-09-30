import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

abstract class I001Listener {
  Future<void> search(Position loadPosition);
}

abstract class I001ManagerInputPort {
  void subscribe(I001Listener h001listener);
  void unSubscribe(I001Listener h001listener);
  int getSubscribeSize();
  search(Position loadPosition);
  Position currentSearchPosition;
}