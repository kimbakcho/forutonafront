abstract class RankingTagListFromBIListener {
  void search();
}

class RankingTagListFromBIManager {
  List<RankingTagListFromBIListener> _rankingTagListFromBIListeners = [];

  subscribe(RankingTagListFromBIListener listener){
    this._rankingTagListFromBIListeners.add(listener);
  }

  unSubscribe(RankingTagListFromBIListener listener){
    this._rankingTagListFromBIListeners.remove(listener);
  }

  search(){
    _rankingTagListFromBIListeners.forEach((element) {
      element.search();
    });
  }

}