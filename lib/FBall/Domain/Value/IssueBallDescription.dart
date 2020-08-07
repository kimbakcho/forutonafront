
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
  

}