import 'package:forutonafront/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallValuationResDto.dart';

class FBallLikeTestUtil {
  static FBallLikeResDto getBasicFBallLikeResDto(
      FBallValuationResDto fBallValuationResDto,
      {int ballPower = 10,
      int ballDislike = 1,
      int ballLike = 11,
      int likeServiceUseUserCount = 12
      }) {
    FBallLikeResDto fBallLikeResDto = new FBallLikeResDto();
    fBallLikeResDto.ballPower = ballPower;
    fBallLikeResDto.ballDislike = ballDislike;
    fBallLikeResDto.ballLike = ballLike;
    fBallLikeResDto.likeServiceUseUserCount = likeServiceUseUserCount;

    fBallLikeResDto.fballValuationResDto = fBallValuationResDto;

    return fBallLikeResDto;
  }
}
