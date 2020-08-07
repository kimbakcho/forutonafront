
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';

abstract class FBallValuationRemoteDataSource {
  Future<FBallLikeResDto> ballLike({@required FBallLikeReqDto reqDto,@required FDio tokenFDio});
}

class FBallValuationRemoteDataSourceImpl implements FBallValuationRemoteDataSource{
  @override
  Future<FBallLikeResDto> ballLike({FBallLikeReqDto reqDto, FDio tokenFDio}) async{
     var response = await tokenFDio.post("/v1/FBallValuation/BallLike",data: reqDto.toJson());
     var fBallLikeResDto = FBallLikeResDto.fromJson(response.data);
    return fBallLikeResDto;
  }

}