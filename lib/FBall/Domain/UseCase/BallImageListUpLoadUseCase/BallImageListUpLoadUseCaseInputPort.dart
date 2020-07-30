import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/ICodePage/IM001/BallImageItem.dart';

abstract class BallImageListUpLoadUseCaseInputPort {
  Future<List<BallImageItem>> ballImageListUpLoadAndFillUrls(List<BallImageItem> refSrcList);
}
class BallImageListUpLoadUseCase implements BallImageListUpLoadUseCaseInputPort {

  final FBallRepository _fBallRepository;

  BallImageListUpLoadUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<List<BallImageItem>> ballImageListUpLoadAndFillUrls(List<BallImageItem> refSrcList) async{
    List<Uint8List> images = [];
    List<BallImageItem> uploadListImageItemDto = [];
    for (var o in refSrcList) {
      if (o.imageByte != null) {
        var image = await decodeImageFromList(o.imageByte);
        var compressImage = await FlutterImageCompress.compressWithList(
          o.imageByte,
          minHeight: image.height.toInt(),
          minWidth: image.width.toInt(),
          quality: 70,
        );
        images.add(Uint8List.fromList(compressImage));
        uploadListImageItemDto.add(o);
      }
    }
    //이미지 업로드 해서 URL 가져옴
    var fBallImageUploadResDto =
        await _fBallRepository.ballImageUpload(images: images);
    for (int i = 0; i < fBallImageUploadResDto.urls.length; i++) {
      uploadListImageItemDto[i].imageUrl = fBallImageUploadResDto.urls[i];
    }
    return refSrcList;
  }

}