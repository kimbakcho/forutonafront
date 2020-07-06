import 'dart:io';
import 'dart:typed_data';

abstract class UserProfileImageUploadUseCaseInputPort {
  Future<String> upload(File image);
}