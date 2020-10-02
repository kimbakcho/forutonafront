import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:injectable/injectable.dart';

abstract class GeoViewSearchListener {
  Future<void> search(Position loadPosition);
}

abstract class GeoViewSearchManagerInputPort {

  List<GeoViewSearchListener> _geoSearchListener;

  void subscribe(GeoViewSearchListener h001listener);

  void unSubscribe(GeoViewSearchListener h001listener);

  int getSubscribeSize();

  search(Position loadPosition);

  Position currentSearchPosition;
}

@LazySingleton(as: GeoViewSearchManagerInputPort)
class GeoViewSearchManager implements GeoViewSearchManagerInputPort {

  List<GeoViewSearchListener> _geoSearchListener = [];

  void subscribe(GeoViewSearchListener h001listener){
    _geoSearchListener.add(h001listener);
  }

  void unSubscribe(GeoViewSearchListener h001listener){
    _geoSearchListener.remove(h001listener);
  }

  int getSubscribeSize(){
    return _geoSearchListener.length;
  }

  search(Position loadPosition){
    currentSearchPosition = loadPosition;
    _geoSearchListener.forEach((element) {
      element.search(loadPosition);
    });
  }

  Position currentSearchPosition;
}
