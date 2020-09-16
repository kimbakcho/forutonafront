import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

abstract class RankingTagListFromBIListener {
  Future<void> search(Position searchPosition);
}

class RankingTagListFromBIManager {
  List<RankingTagListFromBIListener> _rankingTagListFromBIListeners = [];

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
    _rankingTagListFromBIListeners.forEach((element) {
      element.search(searchPosition);
    });
  }
}