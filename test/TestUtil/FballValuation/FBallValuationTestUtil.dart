import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallValuationResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

class FBallValuationTestUtil {
  static FBallValuationResDto getBasicFBallValuationResDto(
      FBallResDto fBallResDto, FUserInfoSimpleResDto fUserInfoSimpleResDto,
      {int ballLike = 1, int ballDislike = 0,int point = 1}) {
    FBallValuationResDto fBallValuationResDto = FBallValuationResDto();
    fBallValuationResDto.valueUuid = "TESTValueUuid";
    fBallValuationResDto.ballUuid = fBallResDto;
    fBallValuationResDto.ballLike = ballLike;
    fBallValuationResDto.ballDislike = ballDislike;
    fBallValuationResDto.uid = fUserInfoSimpleResDto;
    fBallValuationResDto.point = point;
    return fBallValuationResDto;
  }

  static FBallValuationResDto getLogOutUserFBallValuationResDto(
      FBallResDto fBallResDto) {
    FBallValuationResDto fBallValuationResDto = FBallValuationResDto();
    fBallValuationResDto.valueUuid = null;
    fBallValuationResDto.ballUuid = fBallResDto;
    fBallValuationResDto.ballLike = 0;
    fBallValuationResDto.ballDislike = 0;
    fBallValuationResDto.uid = null;
    fBallValuationResDto.point = 0;
    return fBallValuationResDto;
  }
}
