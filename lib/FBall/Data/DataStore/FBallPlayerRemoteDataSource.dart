import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToPlayBall.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToPlayBallWrap.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';

abstract class FBallPlayerRemoteDataSource {
  Future<UserToPlayBallWrap> getUserPlayBallList({@required UserToPlayBallReqDto reqDto,@required FDio noneTokenFDio});
  Future<UserToPlayBall> getUserPlayBall({@required UserToPlayBallSelectReqDto reqDto,@required FDio noneTokenFDio});
}
class FBallPlayerRemoteDataSourceImpl implements FBallPlayerRemoteDataSource{
  @override
  Future<UserToPlayBallWrap> getUserPlayBallList({@required UserToPlayBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBallPlayer/UserToPlayBallList",
        queryParameters: reqDto.toJson());
    return UserToPlayBallWrap.fromJson(response.data);
  }

  @override
  Future<UserToPlayBall> getUserPlayBall({@required UserToPlayBallSelectReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBallPlayer/UserToPlayBall", queryParameters: reqDto.toJson());
    return UserToPlayBall.fromJson(response.data);
  }


}