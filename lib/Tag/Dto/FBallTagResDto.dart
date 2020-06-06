import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTagResDto.g.dart';

@JsonSerializable()
class FBallTagResDto {
  String ballUuid;
  String tagItem;

  FBallTagResDto();

  factory FBallTagResDto.fromJson(Map<String, dynamic> json) => _$FBallTagResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagResDtoToJson(this);

  factory FBallTagResDto.fromFBalltag(FBallTag item){
    FBallTagResDto fBallTagResDto = new FBallTagResDto();
    fBallTagResDto.ballUuid = item.ballUuid;
    fBallTagResDto.tagItem = item.tagItem;
    return fBallTagResDto;
  }
}