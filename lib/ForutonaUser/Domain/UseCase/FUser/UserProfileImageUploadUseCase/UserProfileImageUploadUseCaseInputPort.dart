import 'dart:io';
import 'dart:typed_data';

abstract class UserProfileImageUploadUseCaseInputPort {
  Future<void> upload(File image);
}