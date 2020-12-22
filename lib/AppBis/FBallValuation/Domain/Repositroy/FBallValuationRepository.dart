

import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallLikeResDto.dart';

abstract class FBallValuationRepository {
    Future<FBallLikeResDto> ballLike(FBallLikeReqDto reqDto);
    Future<FBallLikeResDto> getBallLikeState(String ballUuid,String uid);
}