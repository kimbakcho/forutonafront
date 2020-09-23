
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:injectable/injectable.dart';


abstract class FBallValuationRemoteDataSource {
  Future<FBallLikeResDto> ballLike({@required FBallLikeReqDto reqDto,@required FDio tokenFDio});

  Future<FBallLikeResDto> getBallLikeState({String ballUuid,String uid, FDio noneTokenFDio});
}
@Injectable(as: FBallValuationRemoteDataSource)
class FBallValuationRemoteDataSourceImpl implements FBallValuationRemoteDataSource{
  @override
  Future<FBallLikeResDto> ballLike({FBallLikeReqDto reqDto, FDio tokenFDio}) async{
     var response = await tokenFDio.post("/v1/FBallValuation/BallLike",data: reqDto.toJson());
     var fBallLikeResDto = FBallLikeResDto.fromJson(response.data);
    return fBallLikeResDto;
  }

  @override
  Future<FBallLikeResDto> getBallLikeState({String ballUuid, String uid, FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBallValuation/BallLike",queryParameters: {
      "ballUuid":ballUuid,
      "uid":uid
    });
    var fBallLikeResDto = FBallLikeResDto.fromJson(response.data);
    return fBallLikeResDto;
  }

}