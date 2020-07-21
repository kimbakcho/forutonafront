import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'dart:math' as math;

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
abstract class ImageCropUtilInputPort {
  Future<String> saveMemoryImageToAvatarFile(List<int> imageByte,String imageFileName);
}

class ImageCropUtil implements ImageCropUtilInputPort {

  @override
  Future<String> saveMemoryImageToAvatarFile(List<int> imageByte,String imageFileName)async {
    var decodeImage = Img.decodeImage(imageByte);
    var min = math.min(decodeImage.width,decodeImage.height);
    var copyResize = Img.copyResize(decodeImage,height: min,width: min);
    ui.Image image = await loadImage(Img.encodePng(copyResize));
    return await _saveCanvas(image,imageFileName);
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  _saveCanvas(ui.Image image,String imageFileName) async {
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;

    _drawCanvas(image, canvas);

    var pic = pictureRecorder.endRecording();
    ui.Image img = await pic.toImage(image.width, image.height);
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    var buffer = byteData.buffer.asUint8List();

    var documentDirectory = await getApplicationDocumentsDirectory();
    var filePath = '${documentDirectory.path}/$imageFileName';
    File file = File(filePath);
    file.writeAsBytesSync(buffer);
    return filePath;
  }

  Canvas _drawCanvas(ui.Image image, Canvas canvas) {
    var min = math.min(image.width,image.height);
    Path path = Path()
      ..addOval(Rect.fromLTWH(0, 0,
          min.toDouble(), min.toDouble()));
    canvas.clipPath(path);
    canvas.drawImageRect(image,Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(0, 0, min.toDouble(), min.toDouble()), Paint());
    return canvas;
  }

}