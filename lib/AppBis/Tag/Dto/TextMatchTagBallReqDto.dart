

import 'package:json_annotation/json_annotation.dart';

part 'TextMatchTagBallReqDto.g.dart';

@JsonSerializable()
class TextMatchTagBallReqDto {

  final String searchText;
  final double mapCenterLatitude;
  final double mapCenterLongitude;

  TextMatchTagBallReqDto({this.searchText, this.mapCenterLatitude, this.mapCenterLongitude});

  factory TextMatchTagBallReqDto.fromJson(Map<String, dynamic> json) => _$TextMatchTagBallReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TextMatchTagBallReqDtoToJson(this);
}