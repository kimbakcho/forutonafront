
import 'package:forutonafront/FBall/Domain/Value/BallSearchBarHistory.dart';
import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';

abstract class BallSearchBarHistoryRepository{
  Future<void> saveHistory(BallSearchBarHistoryDto saveReq);
  Future<void> removeHistory(BallSearchBarHistoryDto reqDto);
  Future<List<BallSearchBarHistory>> loadHistory();
}