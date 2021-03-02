import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagInsertReqDto.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FBallUpdateReqDto.g.dart';

@JsonSerializable()
class FBallUpdateReqDto {
  String ballUuid;
  double longitude;
  double latitude;
  String ballName;
  FBallType ballType;
  String placeAddress;
  String description;
  List<TagInsertReqDto> tags;


  FBallUpdateReqDto();


  factory FBallUpdateReqDto.fromJson(Map<String, dynamic> json) => _$FBallUpdateReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallUpdateReqDtoToJson(this);

}