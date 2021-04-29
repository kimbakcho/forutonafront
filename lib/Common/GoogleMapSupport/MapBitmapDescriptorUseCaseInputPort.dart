import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageUtilInputPort.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:injectable/injectable.dart';

abstract class MapBitmapDescriptorUseCaseInputPort {
  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size);

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url);
}

@LazySingleton(as: MapBitmapDescriptorUseCaseInputPort)
class MapBitmapDescriptorUseCase
    implements MapBitmapDescriptorUseCaseInputPort {
  ImageUtilInputPort imagePngResizeUtil;
  ImageUtilInputPort imageBorderAvatarUtil;
  FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort;

  MapBitmapDescriptorUseCase(
      {@Named.from(ImagePngResizeUtil) required this.imagePngResizeUtil,
      @Named.from(ImageBorderAvatarUtil) required this.imageBorderAvatarUtil,
      required this.fileDownLoaderUseCaseInputPort});

  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size) async {
    ByteData issueBallIconBytes = await rootBundle.load(filepath);
    return BitmapDescriptor.fromBytes(Uint8List.fromList(imagePngResizeUtil
        .loadResizePngImage(issueBallIconBytes.buffer.asUint8List(),
            size.width.toInt(), size.height.toInt())));
  }

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url) async {
    var iconByte = await fileDownLoaderUseCaseInputPort.downloadToByte(url);
    List<int> bytes = await imageBorderAvatarUtil.exportReSizeImageToByte(
        iconByte!, Size(70, 70));
    return BitmapDescriptor.fromBytes(Uint8List.fromList(bytes));
  }
}
