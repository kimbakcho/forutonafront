import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NoInterestBallRepository)
class NoInterestBallRepositoryImpl implements NoInterestBallRepository {
  final SharedPreferencesAdapter sharedPreferencesAdapter;

  NoInterestBallRepositoryImpl({this.sharedPreferencesAdapter});

  String _noInterestBallKey = "NoInterestBall";
  @override
  Future<bool> existsByBallUuid(String ballUuid) async {
    var stringList = await sharedPreferencesAdapter.getStringList(_noInterestBallKey);
    if(stringList != null && stringList.contains(ballUuid)){
      return true;
    }else {
      return false;
    }
  }

  @override
  Future<List<String>> findByAll() async {
    var list = await sharedPreferencesAdapter.getStringList(_noInterestBallKey);
    if(list == null ){
      return [];
    }else {
      return list;
    }

  }

  @override
  save(String ballUuid) async {
    var stringList = await sharedPreferencesAdapter.getStringList(_noInterestBallKey);
    if(stringList == null){
      stringList = [];
    }
    if(!stringList.contains(ballUuid)){
      stringList.add(ballUuid);
    }
    await sharedPreferencesAdapter.setStringList(_noInterestBallKey, stringList);
  }

  @override
  deleteByBallUuid(String ballUuid) async {
    var stringList = await sharedPreferencesAdapter.getStringList(_noInterestBallKey);
    if(stringList != null){
      stringList.remove(ballUuid);
    }
    await sharedPreferencesAdapter.setStringList(_noInterestBallKey, stringList);
  }
}
