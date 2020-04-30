

import 'package:json_annotation/json_annotation.dart';

import 'FBallValuationResDto.dart';

part 'FBallValuationWrapResDto.g.dart';

@JsonSerializable()
class FBallValuationWrapResDto {


  FBallValuationWrapResDto();
  int count;
  List<FBallValuationResDto>  contents = [];
  factory FBallValuationWrapResDto.fromJson(Map<String, dynamic> json) => _$FBallValuationWrapResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallValuationWrapResDtoToJson(this);
  
}