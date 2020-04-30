
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationWrapResDto.dart';

class FBallValuationRepository {

  Future<FBallValuationWrapResDto> getFBallValuation(FBallValuationReqDto reqDto) async{
    FDio fDio = new FDio('noneToken');
    var response = await fDio.get("/v1/FBallValuation",queryParameters: reqDto.toJson());
    return FBallValuationWrapResDto.fromJson(response.data);
  }

  Future<int> insertFBallValuation( FBallValuationInsertReqDto reqDto) async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var idToken = await currentUser.getIdToken(refresh: true);
    FDio fDio = new FDio(idToken.token);
    var response = await fDio.post("/v1/FBallValuation",data: reqDto.toJson());
    return response.data;
  }

  Future<int> updateFBallValuation( FBallValuationInsertReqDto reqDto) async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var idToken = await currentUser.getIdToken(refresh: true);
    FDio fDio = new FDio(idToken.token);
    var response = await fDio.put("/v1/FBallValuation",data: reqDto.toJson());
    return response.data;
  }

  Future<int> deleteFBallValuation( int idx) async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    var idToken = await currentUser.getIdToken(refresh: true);
    FDio fDio = new FDio(idToken.token);
    var response = await fDio.delete("/v1/FBallValuation/$idx");
    return response.data;
  }

}