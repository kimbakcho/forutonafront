import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTagResDto.g.dart';

@JsonSerializable()
class FBallTagResDto {
  int? idx;
  String? tagItem;
  String? ballUuid;
  int? tagIndex;


  FBallTagResDto();

  static fromJson(Map<String, dynamic> json) => _$FBallTagResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagResDtoToJson(this);


}