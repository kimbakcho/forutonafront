import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageCropUtilInputPort.dart';

abstract class AvatarImageMakerUseCaseInputPort {
  Future<String> makeAvatarImageToFile(String userImageUrl,
      String imageFileName);
}

class AvatarImageMakerUseCase implements AvatarImageMakerUseCaseInputPort {
  final FileDownLoaderUseCaseInputPort _fileDownLoaderUseCaseInputPort;
  final ImageCropUtilInputPort _imageCropUtilInputPort;

  AvatarImageMakerUseCase(
      {@required FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort,
        @required ImageCropUtilInputPort imageCropUtilInputPort
      })
      : _fileDownLoaderUseCaseInputPort = fileDownLoaderUseCaseInputPort,
        _imageCropUtilInputPort = imageCropUtilInputPort;

  Future<String> makeAvatarImageToFile(String userImageUrl,
      String imageFileName) async {
    var largeIconByte =
    await _fileDownLoaderUseCaseInputPort.downloadToByte(userImageUrl);
    var largeIconFilePath = await _imageCropUtilInputPort
        .saveMemoryImageToAvatarFile(largeIconByte, imageFileName);
    return largeIconFilePath;
  }
}
