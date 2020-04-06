import 'dart:convert';

import 'package:forutonafront/HCodePage/H004/SearchBarHistoryUtil/BallSearchbarHistroyDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BallSearchBarHistoryRepository {
  static String shareBallSearchbarHistroy = "BallSearchbarHistroy";

  saveHistory(BallSearchbarHistroyDto saveReq) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<BallSearchbarHistroyDto> historys = getBallSearchHistroyFromPrefs(prefs);
    //중복된게 있으면 지워줌 밑에서 다시 채우기
    historys.removeWhere((x)=> x.searchText==saveReq.searchText);
    historys.sort((a, b) => b.searchTime.compareTo(a.searchTime));
    if (historys.length >= 5) {
      historys.removeLast();
      historys.insert(0, saveReq);
    } else {
      historys.insert(0, saveReq);
    }
    historys.sort((a, b) => b.searchTime.compareTo(a.searchTime));
    prefs.setString(shareBallSearchbarHistroy, json.encode(historys));
    return historys;
  }



  Future<List<BallSearchbarHistroyDto>> removeHistroy(BallSearchbarHistroyDto reqDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<BallSearchbarHistroyDto> historys = getBallSearchHistroyFromPrefs(prefs);
    historys.removeWhere((x)=> x.searchText==reqDto.searchText);
    historys.sort((a, b) => a.searchTime.compareTo(b.searchTime));
    prefs.setString(shareBallSearchbarHistroy, json.encode(historys));
    return historys;
  }

  Future<List<BallSearchbarHistroyDto>> loadHistroy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<BallSearchbarHistroyDto> historys = getBallSearchHistroyFromPrefs(prefs);
    return historys;
  }

  List<BallSearchbarHistroyDto> getBallSearchHistroyFromPrefs(SharedPreferences prefs) {
    List<BallSearchbarHistroyDto> historys = List<BallSearchbarHistroyDto>();
    var listJson = prefs.getString(shareBallSearchbarHistroy);
    if (listJson == null) {
      historys = new List<BallSearchbarHistroyDto>();
    } else {
      var listJson = prefs.getString(shareBallSearchbarHistroy);
      historys = List<BallSearchbarHistroyDto>.from(json
          .decode(listJson)
          .map((x) => BallSearchbarHistroyDto.fromJson(x)));
    }
    return historys;
  }
}
