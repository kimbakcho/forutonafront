
import 'dart:typed_data';

import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';

///볼 이미지를 보여주기 위해 메세지 객체
class BallImageItemDto {
  String imageUrl;
  Uint8List imageByte;
  String mediaType;

  BallImageItemDto();

  factory BallImageItemDto.fromFBallDesImagesDto(FBallDesImagesDto item){
    BallImageItemDto ballImageItemDto = new  BallImageItemDto();
    ballImageItemDto.imageUrl = item.src;
    return ballImageItemDto;
  }
}