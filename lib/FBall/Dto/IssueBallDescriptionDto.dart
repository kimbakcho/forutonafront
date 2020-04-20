//이슈볼안의 내용

import 'package:json_annotation/json_annotation.dart';

import 'FBallDesImagesDto.dart';

part 'IssueBallDescriptionDto.g.dart';

@JsonSerializable(explicitToJson:  true)
class IssueBallDescriptionDto {
  IssueBallDescriptionDto();
  //이슈볼의 내용
  String text;
  List<FBallDesImagesDto> desimages = [];
  String youtubeVideoId;
  factory IssueBallDescriptionDto.fromJson(Map<String, dynamic> json) => _$IssueBallDescriptionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$IssueBallDescriptionDtoToJson(this);
}