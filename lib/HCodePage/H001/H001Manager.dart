import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:injectable/injectable.dart';

abstract class H001Listener {
    Future<void> search(Position loadPosition);
}
@Injectable()
class H001Manager {
  List<H001Listener> _h001Listener = [];

  void subscribe(H001Listener h001listener){
    _h001Listener.add(h001listener);
  }

  void unSubscribe(H001Listener h001listener){
    _h001Listener.remove(h001listener);
  }

  int getSubscribeSize(){
    return _h001Listener.length;
  }

  search(Position loadPosition){
    _h001Listener.forEach((element) {
      element.search(loadPosition);
    });
  }

}