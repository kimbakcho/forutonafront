import 'dart:io';


abstract class UserProfileImageUploadUseCaseInputPort {
  Future<String> upload(File image);
}