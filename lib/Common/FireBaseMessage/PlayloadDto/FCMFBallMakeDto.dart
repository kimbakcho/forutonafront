
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FCMFBallMakeDto.g.dart';

@JsonSerializable()
class FCMFBallMakeDto {
  String? ballMakerNickName;
  String? ballMakerProfileImageUrl;
  String? ballTitle;
  String? ballUuid;
  FBallType? fBallType;
  FCMFBallMakeDto();
  factory FCMFBallMakeDto.fromJson(Map<String, dynamic> json) => _$FCMFBallMakeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FCMFBallMakeDtoToJson(this);
}