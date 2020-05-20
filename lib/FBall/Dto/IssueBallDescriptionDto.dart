
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'IssueBallDescriptionDto.g.dart';

@JsonSerializable()
class IssueBallDescriptionDto {
  String text;
  List<FBallDesImagesDto> desimages = [];
  String youtubeVideoId;

  IssueBallDescriptionDto();
  factory IssueBallDescriptionDto.fromJson(Map<String, dynamic> json) => _$IssueBallDescriptionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$IssueBallDescriptionDtoToJson(this);


}