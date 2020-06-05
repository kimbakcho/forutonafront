import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';

abstract class BallSearchBarHistoryUseCaseOutputPort {
  onLoadHistory(List<BallSearchBarHistoryDto> ballSearchBarHistoryDtos);
  onRemoveHistory();
  onSaveHistory();
}