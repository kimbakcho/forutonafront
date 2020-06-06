import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpFromInfluencePowerUseCaseOutputPort {
  onListUpBallFromBallInfluencePower({@required List<FBallResDto> fBallResDtos,@required String address});
}