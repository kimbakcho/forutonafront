import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageUtilInputPort.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class MapBitmapDescriptorUseCaseInputPort {
  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size);

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url);
}
@LazySingleton(as: MapBitmapDescriptorUseCaseInputPort)
class MapBitmapDescriptorUseCase
    implements MapBitmapDescriptorUseCaseInputPort {
  final ImageUtilInputPort imagePngResizeUtil;
  final ImageUtilInputPort imageBorderAvatarUtil;
  final FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort;

  MapBitmapDescriptorUseCase(
      {@required @Named.from(ImagePngResizeUtil) this.imagePngResizeUtil,
      @required @Named.from(ImageBorderAvatarUtil) this.imageBorderAvatarUtil,
      @required this.fileDownLoaderUseCaseInputPort});


  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size) async {
    ByteData issueBallIconBytes = await rootBundle.load(filepath);
    return BitmapDescriptor.fromBytes(imagePngResizeUtil.loadResizePngImage(
        issueBallIconBytes.buffer.asUint8List(),
        size.width.toInt(),
        size.height.toInt()));
  }

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url) async {
    var iconByte = await fileDownLoaderUseCaseInputPort.downloadToByte(url);
    List<int> bytes = await imageBorderAvatarUtil.exportReSizeImageToByte(
        iconByte, Size(150, 150));
    return BitmapDescriptor.fromBytes(bytes);
  }
}
