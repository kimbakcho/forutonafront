import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallListUpFromSearchTitleReqDto.g.dart';

@JsonSerializable()
class FBallListUpFromSearchTitleReqDto {
  final String searchText;

  final double latitude;
  final double longitude;


  FBallListUpFromSearchTitleReqDto(
      {@required this.searchText,
        this.latitude = 37.508797,
      this.longitude = 126.890605});

  factory FBallListUpFromSearchTitleReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallListUpFromSearchTitleReqDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FBallListUpFromSearchTitleReqDtoToJson(this);
}
