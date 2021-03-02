import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallValuationResDto.dart';

class FBallLikeTestUtil {
  static FBallVoteResDto getBasicFBallLikeResDto(
      FBallValuationResDto fBallValuationResDto,
      {int ballPower = 10,
      int ballDislike = 1,
      int ballLike = 11,
      int likeServiceUseUserCount = 12
      }) {
    FBallVoteResDto fBallLikeResDto = new FBallVoteResDto();
    fBallLikeResDto.ballPower = ballPower;
    fBallLikeResDto.ballDislike = ballDislike;
    fBallLikeResDto.ballLike = ballLike;
    fBallLikeResDto.likeServiceUseUserCount = likeServiceUseUserCount;

    // fBallLikeResDto.fballValuationResDto = fBallValuationResDto;

    return fBallLikeResDto;
  }
}
