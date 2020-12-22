
import 'package:forutonafront/AppBis/FBall/Domain/Value/BallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IssueBallDescription.g.dart';
@JsonSerializable()
class IssueBallDescription extends BallDescription{

  IssueBallDescription();
  factory IssueBallDescription.fromJson(Map<String, dynamic> json) => _$IssueBallDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$IssueBallDescriptionToJson(this);

}