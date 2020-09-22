import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageUtilInputPort.dart';
import 'package:injectable/injectable.dart';

abstract class AvatarImageMakerUseCaseInputPort {
  Future<String> makeAvatarImageToFile(
      String userImageUrl, String imageFileName, Size size);

  Future<List<int>> makeAvatarImageToByte(String userImageUrl, Size size);
}
@Injectable(as: AvatarImageMakerUseCaseInputPort)
class AvatarImageMakerUseCase implements AvatarImageMakerUseCaseInputPort {
  final FileDownLoaderUseCaseInputPort _fileDownLoaderUseCaseInputPort;
  final ImageUtilInputPort _imageUtilInputPort;

  AvatarImageMakerUseCase(
      {@required FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort,
      @required ImageUtilInputPort imageUtilInputPort})
      : _fileDownLoaderUseCaseInputPort = fileDownLoaderUseCaseInputPort,
        _imageUtilInputPort = imageUtilInputPort;

  Future<String> makeAvatarImageToFile(
      String userImageUrl, String imageFileName, Size size) async {
    var largeIconByte =
        await _fileDownLoaderUseCaseInputPort.downloadToByte(userImageUrl);
    var largeIconFilePath = await _imageUtilInputPort
        .saveResizeMemoryImageToFile(largeIconByte, imageFileName, size);
    return largeIconFilePath;
  }

  Future<List<int>> makeAvatarImageToByte(
      String userImageUrl, Size size) async {
    var largeIconByte =
        await _fileDownLoaderUseCaseInputPort.downloadToByte(userImageUrl);
    List<int> bytes =
        await _imageUtilInputPort.exportReSizeImageToByte(largeIconByte, size);
    return bytes;
  }
}
