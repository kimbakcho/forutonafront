import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/BallNameSearchReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallImageUploadResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakerBallResWrapDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class FBallRepository {

  Future<FBallImageUploadResDto> ballImageUpload(List<Uint8List> images)async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken();
    FDio dio = FDio(idToken.token);
    List<MultipartFile> imageFiles = [];
    for (var image in images) {
      imageFiles.add(MultipartFile.fromBytes(image,contentType:MediaType("image", "jpeg"),filename: "ballImage.jpg"));
    }
    var formData = FormData.fromMap({
      "imageFiles": imageFiles
    });
    var response = await dio.post("/v1/FBall/BallImageUpload",data: formData);
    return FBallImageUploadResDto.fromJson(response.data);
  }

  Future<int> insertBall(FBallInsertReqDto reqDto)async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken();
    FDio dio = FDio(idToken.token);
    var response = await dio.post("/v1/FBall/Insert",data: reqDto.toJson());
    return int.parse(response.data);
  }

  /// 지도로 부터 사각형 양끝단을 받아 BackEnd 로 부터 범위 검색
  Future<FBallListUpWrapDto> listUpBallFromMapArea(BallFromMapAreaReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUpFromMapArea", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

  Future<FBallListUpWrapDto> listUpBallFromSearchText(BallNameSearchReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUpFromSearchText", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

  Future<FBallListUpWrapDto> listUpBall(FBallListUpReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUp", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

  /**
   * User가 만든 Ball을 찾음.
   */
  Future<UserToMakerBallResWrapDto> getUserToMakerBalls(UserToMakerBallReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
      await dio.get("/v1/FBall/UserToMakerBalls", queryParameters: reqDto.toJson());
    var userToMakerBallResWrapDto = UserToMakerBallResWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in userToMakerBallResWrapDto.contents) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return userToMakerBallResWrapDto;
  }

}
