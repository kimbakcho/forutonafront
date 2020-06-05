import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';

import 'BallSearchBarHistoryUseCaseInputPort.dart';
import 'BallSearchBarHistoryUseCaseOutputPort.dart';

class BallSearchBarHistoryUseCase implements BallSearchBarHistoryUseCaseInputPort{

  BallSearchBarHistoryRepository _ballSearchBarHistoryRepository = BallSearchBarHistoryRepositoryImpl();

  @override
  Future<List<BallSearchBarHistoryDto>> loadHistory({BallSearchBarHistoryUseCaseOutputPort outputPort}) async{
    var historyList = await _ballSearchBarHistoryRepository.loadHistory();
    var result = historyList.map((x) => BallSearchBarHistoryDto.fromBallSearchBarHistory(x)).toList();
    if(outputPort != null){
      outputPort.onLoadHistory(result);
    }
    return result;
  }

  @override
  Future<void> removeHistory({@required BallSearchBarHistoryDto reqDto,BallSearchBarHistoryUseCaseOutputPort outputPort}) async {
    await _ballSearchBarHistoryRepository.removeHistory(reqDto);
    if(outputPort!= null){
      outputPort.onRemoveHistory();
    }
  }

  @override
  Future<void> saveHistory({@required BallSearchBarHistoryDto reqDto,BallSearchBarHistoryUseCaseOutputPort outputPort}) async {
    await _ballSearchBarHistoryRepository.removeHistory(reqDto);
    if(outputPort!= null){
      outputPort.onSaveHistory();
    }
  }


}