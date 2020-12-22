import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/BallSearchBarHistory.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallSearchBarHistoryDto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: BallSearchBarHistoryRepository)
class BallSearchBarHistoryRepositoryImpl
    implements BallSearchBarHistoryRepository {

  BallSearchHistoryLocalDataSource _localDataSource;

  BallSearchBarHistoryRepositoryImpl(
      {@required BallSearchHistoryLocalDataSource localDataSource })
      :_localDataSource = localDataSource;

  @override
  Future<List<BallSearchBarHistory>> loadHistory() async {
    return _localDataSource.loadHistory(
        sharedPreferences: await SharedPreferences.getInstance());
  }

  @override
  Future<void> removeHistory(BallSearchBarHistoryDto reqDto) async {
    _localDataSource.removeHistory(saveReq: reqDto,
        sharedPreferences: await SharedPreferences.getInstance());
  }

  @override
  Future<void> saveHistory(BallSearchBarHistoryDto reqDto) async {
    _localDataSource.saveHistory(saveReq: reqDto,
        sharedPreferences: await SharedPreferences.getInstance());
  }
}