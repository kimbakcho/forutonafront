import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallReplyResWrap.dart';

import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class FBallReplyDataSource {
  Future<FBallReply> deleteFBallReply(
      String replyUuid,FDio tokenFDio);

  Future<FBallReplyResWrap> getFBallReply(
  FBallReplyReqDto reqDto,FDio noneTokenFDio);

  Future<FBallReply> insertFBallReply(
       FBallReplyInsertReqDto reqDto,  FDio tokenFDio);

  Future<FBallReply> updateFBallReply(
      FBallReplyUpdateReqDto reqDto, FDio tokenFDio);
}
class FBallReplyDataSourceImpl implements FBallReplyDataSource {
  @override
  Future<FBallReply> deleteFBallReply(String replyUuid, FDio tokenFDio) async {
    var response = await tokenFDio.delete("/v1/FBallReply/"+replyUuid);
    return FBallReply.fromJson(response.data);
  }

  @override
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/FBallReply",queryParameters: reqDto.toJson());
    return FBallReplyResWrap.fromJson(response.data);
  }
  @override
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto, FDio tokenFDio) async{
    var response = await tokenFDio.post("/v1/FBallReply", data: reqDto.toJson());
    return FBallReply.fromJson(response.data);
  }

  @override
  Future<FBallReply>
  updateFBallReply(FBallReplyUpdateReqDto reqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/FBallReply", data: reqDto.toJson());
    return FBallReply.fromJson(response.data);
  }

}