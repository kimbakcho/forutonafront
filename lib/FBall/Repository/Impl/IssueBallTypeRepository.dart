import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:geolocator/geolocator.dart';

class IssueBallTypeRepository implements FBallTypeRepository{
  @override
  Future<int> deleteBall(FBallReqDto reqDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.delete("/v1/FBall/Delete",queryParameters: reqDto.toJson());
    return int.parse(response.data);
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
    var fBallResDto = FBallResDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    fBallResDto.distanceWithMapCenter = await Geolocator().distanceBetween(
        fBallResDto.latitude, fBallResDto.longitude, position.latitude, position.longitude);
    fBallResDto.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(fBallResDto.distanceWithMapCenter);
    return fBallResDto;
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