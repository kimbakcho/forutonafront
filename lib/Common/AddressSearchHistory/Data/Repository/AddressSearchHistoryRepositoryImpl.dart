import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Repository/AddressSearchHistoryRepository.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Value/AddressSearchHistory.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddressSearchHistoryRepository)
class AddressSearchHistoryRepositoryImpl
    extends AddressSearchHistoryRepository {
  final SharedPreferencesAdapter sharedPreferencesAdapter;
  final int limitRow = 5 ;
  final String _addressSearchHistoryRepositoryKey =
      "AddressSearchHistoryDataSource";

  AddressSearchHistoryRepositoryImpl(
      {@required this.sharedPreferencesAdapter});

  @override
  Future<void> delete(String search) async {
    var list = await this.findByAll();
    list.removeWhere((element) => element.searchText == search);
    await this
        .sharedPreferencesAdapter
        .setString(_addressSearchHistoryRepositoryKey, json.encode(list));
  }

  @override
  Future<List<AddressSearchHistory>> findByAll() async {
    String value = await this
        .sharedPreferencesAdapter
        .getString(_addressSearchHistoryRepositoryKey);
    if (value == null) {
      return [];
    } else {
      List<dynamic> tempHistories = json.decode(
        value,
      );

      List<AddressSearchHistory> histories = [];
      tempHistories.forEach((element) {
        histories.add(AddressSearchHistory.fromJson(element));
      });

      return histories;
    }
  }

  @override
  Future<AddressSearchHistory> save(String search) async {
    var list = await this.findByAll();
    if (list.length == 0) {
      list = [];
    }
    AddressSearchHistory addressSearchHistory =
        AddressSearchHistory(searchText: search, searchTime: DateTime.now());

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
        .setString(_addressSearchHistoryRepositoryKey, json.encode(list));
    return addressSearchHistory;
  }
}
