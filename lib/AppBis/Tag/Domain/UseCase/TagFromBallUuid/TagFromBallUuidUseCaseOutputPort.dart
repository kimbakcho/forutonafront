
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

abstract class TagFromBallUuidUseCaseOutputPort {
  onTagFromBallUuid(List<FBallTagResDto> ballTags);
  bool isDispose();
}