import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';

class UserProfileImageUploadUseCase
    implements UserProfileImageUploadUseCaseInputPort {
  final FlutterImageCompressAdapter _flutterImageCompressAdapter;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  UserProfileImageUploadUseCase(
      {@required FlutterImageCompressAdapter flutterImageCompressAdapter,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _flutterImageCompressAdapter = flutterImageCompressAdapter,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;

  @override
  Future<String> upload(File imageFile) async {
    var imageBytes = await imageFile.readAsBytes();
    var compressImage =
        await _flutterImageCompressAdapter.compressImage(imageBytes, 70);
    FUserInfo fUserInfo =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    return await fUserInfo.uploadUserProfileImage(compressImage);
  }
}
