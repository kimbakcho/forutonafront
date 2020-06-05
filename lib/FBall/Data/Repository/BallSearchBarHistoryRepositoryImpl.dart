import 'package:forutonafront/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import 'package:forutonafront/FBall/Data/Value/BallSearchBarHistory.dart';
import 'package:forutonafront/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BallSearchBarHistoryRepositoryImpl implements BallSearchBarHistoryRepository {

  BallSearchHistoryLocalDataSource _localDataSource = BallSearchHistoryLocalDataSourceImpl();

  @override
  Future<List<BallSearchBarHistory>> loadHistory() async{
    return _localDataSource.loadHistory(sharedPreferences: await SharedPreferences.getInstance());
  }

  @override
  Future<void> removeHistory(BallSearchBarHistoryDto reqDto) async {
    _localDataSource.removeHistory(saveReq: reqDto,sharedPreferences: await SharedPreferences.getInstance());
  }

  @override
  Future<void> saveHistory(BallSearchBarHistoryDto reqDto) async {
    _localDataSource.saveHistory(saveReq: reqDto,sharedPreferences: await SharedPreferences.getInstance());
  }
}