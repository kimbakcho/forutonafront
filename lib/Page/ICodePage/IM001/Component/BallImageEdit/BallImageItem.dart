
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';

class BallImageItem {
  ImageProvider imageProvider;
  String imageUrl;
  Uint8List imageByte;
  String mediaType;
  FlutterImageCompressAdapter flutterImageCompressAdapter;
  BallImageItem(this.flutterImageCompressAdapter);

  Future<void> addImage({ImageProvider imageProvider,isComPress = true}) async {
    this.imageProvider = imageProvider;
    if(imageProvider is FileImage){
      var imageProvider2 = imageProvider as FileImage;
      imageByte = await imageProvider2.file.readAsBytes();
      if(isComPress){
        imageByte = Uint8List.fromList(await flutterImageCompressAdapter.compressImage(imageByte, 70));
      }
    }else if(imageProvider is NetworkImage){
      var imageProvider2 = imageProvider as NetworkImage;
      imageUrl = imageProvider2.url;
    }
  }

  bool isNeedUpload(){
    return imageByte != null;
  }

}