import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseOp {
  onPositionSearchListUpBall({@required List<FBallResDto> fBallResDtos,@required String address});
}