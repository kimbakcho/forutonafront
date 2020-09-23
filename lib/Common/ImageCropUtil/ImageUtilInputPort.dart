import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';


import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
abstract class ImageUtilInputPort {

  Future<String> saveResizeMemoryImageToFile(List<int> imageByte,String imageFileName,Size size) async {
    return await _saveCanvas(imageByte,imageFileName,size);
  }

  _saveCanvas(List<int> imageByte,String imageFileName,Size size) async {
    var buffer = await exportReSizeImageToByte(imageByte,size);
    var documentDirectory = await getApplicationDocumentsDirectory();
    var filePath = '${documentDirectory.path}/$imageFileName';
    File file = File(filePath);
    file.writeAsBytesSync(buffer);
    return filePath;
  }

  Future<List<int>> exportReSizeImageToByte(List<int> srcImageByte,Size size) async {
    ui.Image image = await loadResizeImage(srcImageByte,size.width.toInt(),size.height.toInt());
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;
    drawCanvas(image, canvas,size);
    var pic = pictureRecorder.endRecording();
    ui.Image img = await pic.toImage(image.width, image.height);
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  Canvas drawCanvas(ui.Image image,Canvas canvas,Size size);

  Future<ui.Image> loadResizeImage(List<int> srcImageByte,int width,int height) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(loadResizePngImage(srcImageByte,width,height), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  List<int> loadResizePngImage(List<int> srcImageByte,int width,int height){
    var decodeImage = Img.decodeImage(srcImageByte);
    var copyResize = Img.copyResize(decodeImage,height: width,width: height);
    return Img.encodePng(copyResize);
  }

}
@Named("ImageAvatarUtil")
@LazySingleton(as: ImageUtilInputPort)
class ImageAvatarUtil extends ImageUtilInputPort {

  @override
  Canvas drawCanvas(ui.Image image,Canvas canvas,Size size) {
    Path path = Path()
      ..addOval(Rect.fromLTWH(0, 0,
          size.width.toDouble(), size.height.toDouble()));
    canvas.clipPath(path);
    canvas.drawImageRect(image,Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(0, 0, size.width.toDouble(), size.height.toDouble()), Paint());
    return canvas;
  }

}
@Named("ImageBorderAvatarUtil")
@LazySingleton(as: ImageUtilInputPort)
class ImageBorderAvatarUtil extends ImageUtilInputPort {

  @override
  Canvas drawCanvas(ui.Image image,Canvas canvas,Size size) {
    Path path = Path()
      ..addOval(Rect.fromLTWH(0, 0,
          size.width.toDouble(), size.height.toDouble()));
    canvas.clipPath(path);
    canvas.drawImageRect(image,Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(0, 0, size.width.toDouble(), size.height.toDouble()), Paint());
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    canvas.drawPath(path, paint);
    
    return canvas;
  }

}
@named
@LazySingleton(as: ImageUtilInputPort)
class ImagePngResizeUtil extends ImageUtilInputPort {

  @override
  Canvas drawCanvas(ui.Image image,Canvas canvas,Size size) {
    canvas.drawImageRect(image,Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTRB(0, 0, size.width.toDouble(), size.height.toDouble()), Paint());
    return canvas;
  }

}