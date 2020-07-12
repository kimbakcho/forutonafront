
import 'package:forutonafront/ICodePage/IM001/BallImageItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallDesImagesDto.g.dart';

@JsonSerializable()
class FBallDesImages {
  int index;
  String src;

  factory FBallDesImages.fromUrl(index,src){
     var fBallDesImagesDto = FBallDesImages();
     fBallDesImagesDto.index = index;
     fBallDesImagesDto.src = src;
     return fBallDesImagesDto;
  }
  factory FBallDesImages.fromBallImageItemDto(int index,BallImageItem item){
    var fBallDesImagesDto = FBallDesImages();
    fBallDesImagesDto.index = index;
    fBallDesImagesDto.src = item.imageUrl;
    return fBallDesImagesDto;
  }


  factory FBallDesImages.fromJson(Map<String, dynamic> json) => _$FBallDesImagesFromJson(json);
  Map<String, dynamic> toJson() => _$FBallDesImagesToJson(this);

  FBallDesImages();
}