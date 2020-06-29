
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';

class FUserRepository {

    //TODO 해당 경우의 대한 updateUserProfileImage UseCase를 만들어 준다.
  //파일 업로드 동시에 UserProfileUrl 에 BackEnd 에서  UserInfo 의 정보에 이미지 Url 을 넣어준다.
//  Future<String> updateUserProfileImage(File file) async {
//    var firebaseUser = await FirebaseAuth.instance.currentUser();
//    var idToken = await firebaseUser.getIdToken(refresh: true);
//    FDio dio = FDio(idToken.token);
//    var uint8list = await file.readAsBytes();
//    var image = await decodeImageFromList(uint8list);
//    var compressImage = await FlutterImageCompress.compressWithList(
//      uint8list,
//      minHeight: image.height.toInt(),
//      minWidth: image.width.toInt(),
//      quality: 70,
//    );
//    FormData formData = FormData.fromMap({
//      "ProfileImage": MultipartFile.fromBytes(compressImage,contentType: MediaType("image", "jpeg"),filename: "ProfileImage.jpg")
//    });
//    var response = await dio.put("/v1/ForutonaUser/ProfileImage",data: formData);
//    return response.data;
//  }




}
