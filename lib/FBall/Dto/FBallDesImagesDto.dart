
import 'package:json_annotation/json_annotation.dart';

part 'FBallDesImagesDto.g.dart';

@JsonSerializable()
class FBallDesImagesDto {
  int index;
  String src;

  factory FBallDesImagesDto.fromUrl(index,src){
     var fBallDesImagesDto = FBallDesImagesDto();
     fBallDesImagesDto.index = index;
     fBallDesImagesDto.src = src;
     return fBallDesImagesDto;
  }

  factory FBallDesImagesDto.fromJson(Map<String, dynamic> json) => _$FBallDesImagesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallDesImagesDtoToJson(this);

  FBallDesImagesDto();
}