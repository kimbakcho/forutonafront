import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageUtilInputPort.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapBitmapDescriptorUseCaseInputPort {
  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size);

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url);
}

class MapBitmapDescriptorUseCase
    implements MapBitmapDescriptorUseCaseInputPort {
  final ImageUtilInputPort _imagePngResizeUtil;
  final ImageUtilInputPort _imageBorderAvatarUtil;
  final FileDownLoaderUseCaseInputPort _fileDownLoaderUseCaseInputPort;

  MapBitmapDescriptorUseCase(
      {@required ImageUtilInputPort imagePngResizeUtil,
      @required ImageUtilInputPort imageBorderAvatarUtil,
      @required FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort})
      : _imagePngResizeUtil = imagePngResizeUtil,
        _imageBorderAvatarUtil = imageBorderAvatarUtil,
        _fileDownLoaderUseCaseInputPort = fileDownLoaderUseCaseInputPort;

  Future<BitmapDescriptor> assertFileToBitmapDescriptor(
      String filepath, Size size) async {
    ByteData issueBallIconBytes = await rootBundle.load(filepath);
    return BitmapDescriptor.fromBytes(_imagePngResizeUtil.loadResizePngImage(
        issueBallIconBytes.buffer.asUint8List(),
        size.width.toInt(),
        size.height.toInt()));
  }

  Future<BitmapDescriptor> urlPathToAvatarBitmapDescriptor(String url) async {
    var iconByte = await _fileDownLoaderUseCaseInputPort.downloadToByte(url);
    List<int> bytes = await _imageBorderAvatarUtil.exportReSizeImageToByte(
        iconByte, Size(150, 150));
    return BitmapDescriptor.fromBytes(bytes);
  }
}
