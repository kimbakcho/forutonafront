
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';

abstract class TagFromBallUuidUseCaseOutputPort {
  onTagFromBallUuid(List<FBallTagResDto> ballTags);
}