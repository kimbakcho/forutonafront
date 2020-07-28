import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseOutputPort {
   void searchResult(PageWrap<FBallResDto> listUpItem);
}