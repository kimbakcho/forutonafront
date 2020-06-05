
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';


import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:meta/meta.dart';

abstract class FBallRemoteDataSource {
  Future<FBallListUpWrap> listUpFromPosition(
    {@required FBallListUpReqDto fBallListUpReqDto,@required FDio noneTokenFDio});
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto,@required FDio noneTokenFDio});
}

class FBallRemoteSourceImpl implements FBallRemoteDataSource {

  @override
  Future<FBallListUpWrap> listUpFromPosition(
      {@required FBallListUpReqDto fBallListUpReqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FBall/BallListUp",
        queryParameters: fBallListUpReqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

  @override
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBall/UserToMakerBalls", queryParameters: reqDto.toJson());
    return UserToMakeBallWrap.fromJson(response.data);
  }

}