import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';


class FBallReplyRepository {
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.post("/v1/FBallReply", data: reqDto.toJson());
    return FBallReplyResDto.fromJson(response.data);
  }

  Future<FBallReplyResWrapDto> getFBallReply(FBallReplyReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.get("/v1/FBallReply",queryParameters: reqDto.toJson());
    return FBallReplyResWrapDto.fromJson(response.data);
  }

  Future<FBallReplyResWrapDto> getFBallSubReply(FBallReplyReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.get("/v1/FBallSubReply",queryParameters: reqDto.toJson());
    return FBallReplyResWrapDto.fromJson(response.data);
  }


  Future<int> updateFBallReply(FBallReplyInsertReqDto reqDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.put("/v1/FBallReply", data: reqDto.toJson());
    return response.data;
  }

  Future<int> deleteFBallReply(String replyUuid) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.delete("/v1/FBallReply/"+replyUuid);
    return response.data;
  }
}
