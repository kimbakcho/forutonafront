
import 'dart:typed_data';

import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

class BallImageItem {
  String imageUrl;
  Uint8List imageByte;
  String mediaType;

  BallImageItem();

  factory BallImageItem.fromFBallDesImagesDto(FBallDesImages item){
    BallImageItem ballImageItemDto = new  BallImageItem();
    ballImageItemDto.imageUrl = item.src;
    return ballImageItemDto;
  }
  bool hasImageUrl(){
    return imageUrl != null;
  }
}