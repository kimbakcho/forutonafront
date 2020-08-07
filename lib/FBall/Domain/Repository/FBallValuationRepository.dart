import 'package:forutonafront/FBall/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';

abstract class FBallValuationRepository {
    Future<FBallLikeResDto> ballLike(FBallLikeReqDto reqDto);
    Future<FBallLikeResDto> getBallLikeState(String ballUuid,String uid);
}