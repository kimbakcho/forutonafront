import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallSearchBarHistoryDto.dart';
import 'package:injectable/injectable.dart';


abstract class FBallSearchBarHistoryUseCaseInputPort {
  Future<void> saveHistory({@required BallSearchBarHistoryDto reqDto,FBallSearchBarHistoryUseCaseOutputPort outputPort});
  Future<void> removeHistory({@required BallSearchBarHistoryDto reqDto,FBallSearchBarHistoryUseCaseOutputPort outputPort});
  Future<List<BallSearchBarHistoryDto>> loadHistory({FBallSearchBarHistoryUseCaseOutputPort outputPort});
}
abstract class FBallSearchBarHistoryUseCaseOutputPort {
  onLoadHistory(List<BallSearchBarHistoryDto> ballSearchBarHistoryDtos);
  onRemoveHistory();
  onSaveHistory();
}
@LazySingleton(as: FBallSearchBarHistoryUseCaseInputPort)
class FBallSearchBarHistoryUseCase
    implements FBallSearchBarHistoryUseCaseInputPort {
  BallSearchBarHistoryRepository _ballSearchBarHistoryRepository;

  FBallSearchBarHistoryUseCase(
      {BallSearchBarHistoryRepository ballSearchBarHistoryRepository})
      : _ballSearchBarHistoryRepository = ballSearchBarHistoryRepository;

  @override
  Future<List<BallSearchBarHistoryDto>> loadHistory(
      {FBallSearchBarHistoryUseCaseOutputPort outputPort}) async {
    var historyList = await _ballSearchBarHistoryRepository.loadHistory();
    var result = historyList
        .map((x) => BallSearchBarHistoryDto.fromBallSearchBarHistory(x))
        .toList();
    if (outputPort != null) {
      outputPort.onLoadHistory(result);
    }
    return result;
  }

  @override
  Future<void> removeHistory(
      {@required BallSearchBarHistoryDto reqDto,
        FBallSearchBarHistoryUseCaseOutputPort outputPort}) async {
    await _ballSearchBarHistoryRepository.removeHistory(reqDto);
    if (outputPort != null) {
      outputPort.onRemoveHistory();
    }
  }

  @override
  Future<void> saveHistory(
      {@required BallSearchBarHistoryDto reqDto,
        FBallSearchBarHistoryUseCaseOutputPort outputPort}) async {
    await _ballSearchBarHistoryRepository.saveHistory(reqDto);
    if (outputPort != null) {
      outputPort.onSaveHistory();
    }
  }
}
