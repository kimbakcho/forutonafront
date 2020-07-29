import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpUseCaseOutputPort.dart';

abstract class FBallListUpUseCaseInputPort {
  Future<PageWrap<FBallResDto>> search(dynamic reqDto,
      Pageable pageable, FBallListUpUseCaseOutputPort outputPort);
}
