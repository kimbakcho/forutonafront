import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';

class UserProfileImageUploadUseCase
    implements UserProfileImageUploadUseCaseInputPort {
  FUserRepository _fUserRepository;
  FlutterImageCompressAdapter _flutterImageCompressAdapter;

  UserProfileImageUploadUseCase(
      {@required FUserRepository fUserRepository, @required FlutterImageCompressAdapter flutterImageCompressAdapter})
      : _fUserRepository = fUserRepository,
        _flutterImageCompressAdapter=flutterImageCompressAdapter;


  @override
  Future<void> upload(File imageFile) async {
    var imageBytes = await imageFile.readAsBytes();
    var compressImage = await _flutterImageCompressAdapter.compressImage(
        imageBytes, 70);
    FormData formData = FormData.fromMap({
      "ProfileImage": MultipartFile.fromBytes(
          compressImage, contentType: MediaType("image", "jpeg"),
          filename: "ProfileImage.jpg")
    });
    await _fUserRepository.uploadUserProfileImage(formData);
  }
}
