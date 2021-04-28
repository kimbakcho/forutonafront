import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Value/SearchHistory.dart';

import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';



class SearchHistoryRepositoryImpl
    extends SearchHistoryRepository {
  final SharedPreferencesAdapter sharedPreferencesAdapter;
  final int limitRow = 5 ;
  final SearchHistoryDataSourceKey? searchHistoryDataSourceKey;

  SearchHistoryRepositoryImpl(
      {required this.sharedPreferencesAdapter,this.searchHistoryDataSourceKey});

  @override
  Future<void> delete(String search,String uid) async {
    var list = await this.findByAll(uid);
    list.removeWhere((element) => element.searchText == search);
    await this
        .sharedPreferencesAdapter
        .setString(EnumToString.convertToString(searchHistoryDataSourceKey)+uid, json.encode(list));
  }

  @override
  Future<List<SearchHistory>> findByAll(String uid) async {
    String? value = await this
        .sharedPreferencesAdapter
        .getString(EnumToString.convertToString(searchHistoryDataSourceKey)+uid);
    if (value == null) {
      return [];
    } else {
      List<dynamic> tempHistories = json.decode(
        value,
      );

      List<SearchHistory> histories = [];
      tempHistories.forEach((element) {
        histories.add(SearchHistory.fromJson(element));
      });

      return histories;
    }
  }

  @override
  Future<SearchHistory> save(String search,String uid) async {
    var list = await this.findByAll(uid);
    if (list.length == 0) {
      list = [];
    }
    SearchHistory addressSearchHistory =
        SearchHistory(searchText: search, searchTime: DateTime.now());

    var indexWhere = list.indexWhere((element) => element.searchText == search);
    if(indexWhere != -1){
      list.removeAt(indexWhere);
    }
    list.insert(0, addressSearchHistory);
    if (list.length > 5) {
      list.removeLast();
    }

    await this
        .sharedPreferencesAdapter
        .setString(EnumToString.convertToString(searchHistoryDataSourceKey)+uid, json.encode(list));
    return addressSearchHistory;
  }
}
