import 'package:json_annotation/json_annotation.dart';
part 'FBallImageUploadResDto.g.dart';

@JsonSerializable()
class FBallImageUploadResDto {
  int count;
  List<String> urls;
  FBallImageUploadResDto();
  factory FBallImageUploadResDto.fromJson(Map<String, dynamic> json) => _$FBallImageUploadResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallImageUploadResDtoToJson(this);


}