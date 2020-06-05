import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Value/BallSearchBarHistory.dart';
import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';

import 'BallSearchBarHistoryUseCaseOutputPort.dart';

abstract class BallSearchBarHistoryUseCaseInputPort {
  Future<void> saveHistory({@required BallSearchBarHistoryDto reqDto,BallSearchBarHistoryUseCaseOutputPort outputPort});
  Future<void> removeHistory({@required BallSearchBarHistoryDto reqDto,BallSearchBarHistoryUseCaseOutputPort outputPort});
  Future<List<BallSearchBarHistoryDto>> loadHistory({BallSearchBarHistoryUseCaseOutputPort outputPort});
}