import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/BallSearchBarHistory.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallSearchBarHistoryDto.dart';

import 'package:injectable/injectable.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class  BallSearchHistoryLocalDataSource {
  void saveHistory({@required BallSearchBarHistoryDto saveReq,@required SharedPreferences sharedPreferences});
  void removeHistory({@required BallSearchBarHistoryDto saveReq,@required SharedPreferences sharedPreferences});
  List<BallSearchBarHistory> loadHistory({@required SharedPreferences sharedPreferences});
}
@LazySingleton(as: BallSearchHistoryLocalDataSource)
class BallSearchHistoryLocalDataSourceImpl implements BallSearchHistoryLocalDataSource{
  static String shareBallSearchBarHistory = "BallSearchbarHistroy";
  static int historyListLimit = 5;


  @override
  void saveHistory({@required BallSearchBarHistoryDto saveReq,@required SharedPreferences sharedPreferences}) {
    List<BallSearchBarHistory> historyList = getBallSearchHistoryFromPrefs(sharedPreferences);
    if(hasHistory(saveReq,historyList)){
      removeHistory(saveReq: saveReq,sharedPreferences: sharedPreferences);
    }
    historySortOrderDesc(historyList);
    if(isOverSaveLimit(historyList)){
      historyList.removeLast();
    }
    insertHistoryFirst(historyList, saveReq);
    sharedPreferences.setString(shareBallSearchBarHistory, json.encode(historyList));
  }

  void removeHistory({@required BallSearchBarHistoryDto saveReq,@required SharedPreferences sharedPreferences}) {
    List<BallSearchBarHistory> historyList = getBallSearchHistoryFromPrefs(sharedPreferences);
    historyList.removeWhere((x)=> x.searchText==saveReq.searchText);
    historySortOrderDesc(historyList);
    sharedPreferences.setString(shareBallSearchBarHistory, json.encode(historyList));
  }

  @override
  List<BallSearchBarHistory> loadHistory({@required  SharedPreferences sharedPreferences}) {
    List<BallSearchBarHistory> historyList = getBallSearchHistoryFromPrefs(sharedPreferences);
    return historyList;
  }

  void insertHistoryFirst(List<BallSearchBarHistory> historyList, BallSearchBarHistoryDto saveReq) => historyList.insert(0, BallSearchBarHistory.fromBallSearchBarHistoryDto(saveReq));

  List<BallSearchBarHistory> getBallSearchHistoryFromPrefs(SharedPreferences prefs) {
    List<BallSearchBarHistory> historyList = List<BallSearchBarHistory>();
    if (hasSaveFile(prefs)) {
      var saveJsonText = getSaveJsonText(prefs);
      historyList = List<BallSearchBarHistory>.from(json
          .decode(saveJsonText)
          .map((x) => BallSearchBarHistory.fromJson(x)));
    } else {
      historyList = new List<BallSearchBarHistory>();
    }
    return historyList;
  }


  String getSaveJsonText(SharedPreferences prefs) => prefs.getString(shareBallSearchBarHistory);


  bool hasSaveFile(SharedPreferences prefs) {
    var listJson = getSaveJsonText(prefs);
    if(listJson == null){
      return false;
    }else {
      return true;
    }
  }

  bool hasHistory(BallSearchBarHistoryDto saveReq, List<BallSearchBarHistory> historyList) {
    var indexWhere = historyList.indexWhere((element) => element.searchText == saveReq.searchText);
    if(indexWhere >=0 ){
      return true;
    }else {
      return false;
    }
  }


  void historySortOrderDesc(List<BallSearchBarHistory> historyList) {
    historyList.sort((a, b) => b.searchTime.compareTo(a.searchTime));
  }

  bool isOverSaveLimit(List<BallSearchBarHistory> historyList) {
    if(historyList.length >= historyListLimit){
      return true;
    }else {
      return false;
    }
  }

}