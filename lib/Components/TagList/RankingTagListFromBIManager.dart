import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:injectable/injectable.dart';

abstract class RankingTagListFromBIListener {
  Future<void> search(Position searchPosition);
}
abstract class RankingTagListFromBIManagerInputPort{
  void subscribe(RankingTagListFromBIListener listener);
  void unSubscribe(RankingTagListFromBIListener listener);
  int getSubscribeSize();
  search(Position searchPosition);
}

@Injectable(as: RankingTagListFromBIManagerInputPort)
class RankingTagListFromBIManager implements RankingTagListFromBIManagerInputPort{
  List<RankingTagListFromBIListener> _rankingTagListFromBIListeners = [];
  Position currentSearchPosition;

  void subscribe(RankingTagListFromBIListener listener){
    this._rankingTagListFromBIListeners.add(listener);
  }

  void unSubscribe(RankingTagListFromBIListener listener){
    this._rankingTagListFromBIListeners.remove(listener);
  }

  int getSubscribeSize(){
    return this._rankingTagListFromBIListeners.length;
  }

  search(Position searchPosition){
    currentSearchPosition = searchPosition;
    _rankingTagListFromBIListeners.forEach((element) {
      element.search(searchPosition);
    });
  }
}