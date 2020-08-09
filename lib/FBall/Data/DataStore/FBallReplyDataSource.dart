import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class FBallReplyDataSource {
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid, FDio tokenFDio);

  Future<PageWrap<FBallReplyResDto>> getFBallReply(
      FBallReplyReqDto reqDto, Pageable pageable, FDio noneTokenFDio);

  Future<FBallReplyResDto> insertFBallReply(
      FBallReplyInsertReqDto reqDto, FDio tokenFDio);

  Future<FBallReplyResDto> updateFBallReply(
      FBallReplyUpdateReqDto reqDto, FDio tokenFDio);

  Future<int> getBallReviewCount(String ballUuid, FDio fDio);


}

class FBallReplyDataSourceImpl implements FBallReplyDataSource {
  @override
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid, FDio tokenFDio) async {
    var response = await tokenFDio.delete("/v1/FBallReply/" + replyUuid);
    return FBallReplyResDto.fromJson(response.data);
  }

  @override
  Future<PageWrap<FBallReplyResDto>> getFBallReply(
      FBallReplyReqDto reqDto, Pageable pageable, FDio noneTokenFDio) async {
    Map<String,dynamic> jsonReq = reqDto.toJson();
    jsonReq.addAll(pageable.toJson());


    var response = await noneTokenFDio.get("/v1/FBallReply",
        queryParameters: jsonReq);
    return PageWrap<FBallReplyResDto>.fromJson(
        response.data, FBallReplyResDto.fromJson);
  }

  @override
  Future<FBallReplyResDto> insertFBallReply(
      FBallReplyInsertReqDto reqDto, FDio tokenFDio) async {
    var response =
        await tokenFDio.post("/v1/FBallReply", data: reqDto.toJson());
    return FBallReplyResDto.fromJson(response.data);
  }

  @override
  Future<FBallReplyResDto> updateFBallReply(
      FBallReplyUpdateReqDto reqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/FBallReply", data: reqDto.toJson());
    return FBallReplyResDto.fromJson(response.data);
  }

  @override
  Future<int> getBallReviewCount(String ballUuid, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get<int>("/v1/FBallReply/Count", queryParameters: {
      "ballUuid":ballUuid
    });
    return response.data;
  }
}
