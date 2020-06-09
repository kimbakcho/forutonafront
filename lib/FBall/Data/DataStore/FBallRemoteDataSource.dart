

import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';



import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:meta/meta.dart';

abstract class FBallRemoteDataSource {
  Future<FBallListUpWrap> listUpFromInfluencePower(
    {@required FBallListUpFromBallInfluencePowerReqDto fBallListUpFromInfluencePowerReqDto,@required FDio noneTokenFDio});
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallListUpWrap> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallListUpWrap> listUpFromTagName({@required FBallListUpFromTagNameReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallListUpWrap> listUpBallFromMapArea({@required BallFromMapAreaReqDto reqDto,@required FDio noneTokenFDio});

}

class FBallRemoteSourceImpl implements FBallRemoteDataSource {

  @override
  Future<FBallListUpWrap> listUpFromInfluencePower(
      {@required FBallListUpFromBallInfluencePowerReqDto fBallListUpFromInfluencePowerReqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FBall/ListUpFromBallInfluencePower",
        queryParameters: fBallListUpFromInfluencePowerReqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

  @override
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBall/UserToMakerBalls", queryParameters: reqDto.toJson());
    return UserToMakeBallWrap.fromJson(response.data);
  }

  @override
  Future<FBallListUpWrap> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromSearchTitle", queryParameters: reqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

  @override
  Future<FBallListUpWrap> listUpFromTagName({@required FBallListUpFromTagNameReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromTagName", queryParameters: reqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

  @override
  Future<FBallListUpWrap> listUpBallFromMapArea({@required  BallFromMapAreaReqDto reqDto,@required  FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromMapArea", queryParameters: reqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }
}