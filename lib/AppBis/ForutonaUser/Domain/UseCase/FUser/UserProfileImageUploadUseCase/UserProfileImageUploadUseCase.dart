import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileImageUploadUseCaseInputPort)
class UserProfileImageUploadUseCase
    implements UserProfileImageUploadUseCaseInputPort {
  final FlutterImageCompressAdapter _flutterImageCompressAdapter;

  final FUserRepository _fUserRepository;

  UserProfileImageUploadUseCase(
      {required FlutterImageCompressAdapter flutterImageCompressAdapter,
      required FUserRepository fUserRepository})
      : _flutterImageCompressAdapter = flutterImageCompressAdapter,
        _fUserRepository = fUserRepository;

  @override
  Future<String> upload(File imageFile) async {
    var imageBytes = await imageFile.readAsBytes();
    var compressImage =
        await _flutterImageCompressAdapter.compressImage(imageBytes, 70);
    return await _fUserRepository.uploadUserProfileImage(compressImage);
  }
}
