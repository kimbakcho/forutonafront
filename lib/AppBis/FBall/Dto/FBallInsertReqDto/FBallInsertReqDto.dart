import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagInsertReqDto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'FBallInsertReqDto.g.dart';
@JsonSerializable()
class FBallInsertReqDto {
  String ballUuid;
  double longitude;
  double latitude;
  String ballName;
  FBallType ballType;
  String placeAddress;
  String description;
  List<TagInsertReqDto> tags;

  FBallInsertReqDto();

  factory FBallInsertReqDto.fromJson(Map<String, dynamic> json) => _$FBallInsertReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallInsertReqDtoToJson(this);

}