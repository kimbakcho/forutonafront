import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';

abstract class FBallReplyDataSource {
  Future<int> deleteFBallReply(
      String replyUuid,FDio tokenFDio);

  Future<FBallReplyResWrap> getFBallReply(
  FBallReplyReqDto reqDto,FDio noneTokenFDio);

  Future<FBallReplyResWrap> getFBallSubReply(
      FBallReplyReqDto reqDto,FDio noneTokenFDio);

  Future<FBallReply> insertFBallReply(
       FBallReplyInsertReqDto reqDto,  FDio tokenFDio);

  Future<int> updateFBallReply(
       FBallReplyInsertReqDto reqDto, FDio tokenFDio);
}
class FBallReplyDataSourceImpl implements FBallReplyDataSource {
  @override
  Future<int> deleteFBallReply(String replyUuid, FDio tokenFDio) async {
    var response = await tokenFDio.delete("/v1/FBallReply/"+replyUuid);
    return response.data;
  }

  @override
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/FBallReply",queryParameters: reqDto.toJson());
    return FBallReplyResWrap.fromJson(response.data);
  }

  @override
  Future<FBallReplyResWrap> getFBallSubReply(FBallReplyReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/FBallSubReply",queryParameters: reqDto.toJson());
    return FBallReplyResWrap.fromJson(response.data);
  }

  @override
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto, FDio tokenFDio) async{
    var response = await tokenFDio.post("/v1/FBallReply", data: reqDto.toJson());
    return FBallReply.fromJson(response.data);
  }

  @override
  Future<int> updateFBallReply(FBallReplyInsertReqDto reqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/FBallReply", data: reqDto.toJson());
    return response.data;
  }

}