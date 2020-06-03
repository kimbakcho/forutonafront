
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Value/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:meta/meta.dart';

abstract class IFBallRemoteDataSource {
  Future<FBallListUpWrap> listUpFromPosition(
    {@required FBallListUpReqDto fBallListUpReqDto,@required FDio noneTokenFDio});
}

class FBallRemoteSourceImpl implements IFBallRemoteDataSource {

  @override
  Future<FBallListUpWrap> listUpFromPosition(
      {@required FBallListUpReqDto fBallListUpReqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FBall/BallListUp",
        queryParameters: fBallListUpReqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

}