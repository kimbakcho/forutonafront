
import 'package:json_annotation/json_annotation.dart';

part 'FBallImageUpload.g.dart';

@JsonSerializable()
class FBallImageUpload {
  int count;
  List<String> urls;
  FBallImageUpload();
  factory FBallImageUpload.fromJson(Map<String, dynamic> json) => _$FBallImageUploadFromJson(json);
  Map<String, dynamic> toJson() => _$FBallImageUploadToJson(this);
}