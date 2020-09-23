import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';

abstract class FlutterImageCompressAdapter {
  Future<List<int>> compressImage(Uint8List imageBytes,int quality);
}
@LazySingleton(as: FlutterImageCompressAdapter)
class FlutterImageCompressAdapterImpl implements FlutterImageCompressAdapter{
  @override
  Future<List<int>> compressImage(Uint8List imageBytes,int quality) async {
    var image = await decodeImageFromList(imageBytes);
    var compressImage = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: image.height.toInt(),
      minWidth: image.width.toInt(),
      quality: quality,
    );
    return compressImage;
  }

}