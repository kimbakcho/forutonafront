
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseInputPort {

  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});
}

abstract class FBallListUpUseCaseOutputPort {
  void searchResult(PageWrap<FBallResDto> listUpItem);
}