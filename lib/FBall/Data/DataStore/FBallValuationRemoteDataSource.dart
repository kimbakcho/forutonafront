import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuationWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';


abstract class FBallValuationRemoteDataSource {
  Future<void> deleteFBallValuation({@required String valueUuid,@required FDio tokenFDio});
  Future<FBallValuationWrap> getFBallValuation({@required FBallValuationReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallValuation> save({@required FBallValuationInsertReqDto reqDto,@required FDio tokenFDio});
}
class FBallValuationRemoteDataSourceImpl implements FBallValuationRemoteDataSource {
  @override
  Future<void> deleteFBallValuation({@required String valueUuid,@required FDio tokenFDio}) async {
    await tokenFDio.delete("/v1/FBallValuation/$valueUuid");
  }

  @override
  Future<FBallValuationWrap> getFBallValuation({@required FBallValuationReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FBallValuation",queryParameters: reqDto.toJson());
    return FBallValuationWrap.fromJson(response.data);
  }

  @override
  Future<FBallValuation> save({@required FBallValuationInsertReqDto reqDto,@required FDio tokenFDio}) async{
    var response = await tokenFDio.post("/v1/FBallValuation",data: reqDto.toJson());
    return FBallValuation.fromJson(response.data);
  }


}