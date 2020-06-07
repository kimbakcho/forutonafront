import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';
import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:http_parser/http_parser.dart';

abstract class IssueBallTypeRemoteDateSource {
  Future<int> deleteBall({@required FBallReqDto reqDto,@required FDio fDio});
  Future<int> insertBall({@required IssueBallInsertReqDto reqDto,@required FDio fDio});
  Future<FBall> selectBall({@required  FBallReqDto reqDto,@required FDio fDio});
  Future<int> updateBall({@required IssueBallUpdateReqDto reqDto,@required FDio fDio});
  Future<int> joinBall({@required FBallJoinReqDto reqDto,@required FDio fDio});
  Future<int> ballHit({@required FBallReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images,@required FDio tokenFDio});
}
class IssueBallTypeRemoteDateSourceImpl implements IssueBallTypeRemoteDateSource{

  IssueBallTypeRemoteDateSourceImpl();

  @override
  Future<int> ballHit({@required  FBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.post("/v1/FBall/Issue/BallHit",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> deleteBall({@required FBallReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.delete("/v1/FBall/Issue/Delete",queryParameters: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> insertBall({@required IssueBallInsertReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.post("/v1/FBall/Issue/Insert",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> joinBall({@required FBallJoinReqDto reqDto,@required FDio fDio})async {
      var response = await fDio.post("/v1/FBall/Issue/Join",data: reqDto.toJson());
      return int.parse(response.data);
    }

  @override
  Future<FBall> selectBall({@required FBallReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.post("/v1/FBall/Issue/Select",queryParameters: reqDto.toJson());
    return FBall.fromJson(response.data);
  }

  @override
  Future<int> updateBall({@required IssueBallUpdateReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.put("/v1/FBall/Issue/Update",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images, @required FDio tokenFDio}) async {
    List<MultipartFile> imageFiles = [];
    for (var image in images) {
      imageFiles.add(MultipartFile.fromBytes(image,contentType:MediaType("image", "jpeg"),filename: "ballImage.jpg"));
    }
    var formData = FormData.fromMap({
      "imageFiles": imageFiles
    });
    var response = await tokenFDio.post("/v1/FBall/BallImageUpload",data: formData);
    return FBallImageUpload.fromJson(response.data);
  }
}


