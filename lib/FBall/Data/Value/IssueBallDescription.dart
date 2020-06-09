
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IssueBallDescription.g.dart';
@JsonSerializable()
class IssueBallDescription {
  String text;
  List<FBallDesImages> desimages = [];
  String youtubeVideoId;

  IssueBallDescription();
  factory IssueBallDescription.fromJson(Map<String, dynamic> json) => _$IssueBallDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$IssueBallDescriptionToJson(this);

  bool isMainPicture() {
    if (desimages.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  String mainPictureSrc(){
    if (isMainPicture()) {
      return desimages[0].src;
    } else {
      return null;
    }
  }

  int pictureCount(){
    return desimages.length;
  }

  bool hasYoutubeVideo(){
    if(youtubeVideoId == null || youtubeVideoId.length == 0){
      return false;
    }else {
      return true;
    }
  }

}