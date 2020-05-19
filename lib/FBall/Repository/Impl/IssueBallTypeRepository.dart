import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';

class IssueBallTypeRepository implements FBallTypeRepository{
  @override
  Future<int> deleteBall(FBallReqDto fBallReqDto) async {
    return 0;
  }

  @override
  Future<int> insertBall(FBallInsertReqDto reqDto) async  {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.post("/v1/FBall/Insert",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<FBallResDto> selectBall(FBallReqDto fBallReqDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.post("/v1/FBall/Select",queryParameters: fBallReqDto.toJson());
    return FBallResDto.fromJson(response.data);
  }

  @override
  Future<int> updateBall(FBallInsertReqDto reqDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.put("/v1/FBall/Update",data: reqDto.toJson());
    return int.parse(response.data);
  }


}