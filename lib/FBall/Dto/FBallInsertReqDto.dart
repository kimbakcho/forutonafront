import 'package:forutonafront/Tag/Dto/TagInsertReqDto.dart';
import '../Data/Value/FBallType.dart';
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
   String administrativeArea;
   String country;
   String ballPassword;
   int maximumPlayers;
   String description;
  List<TagInsertReqDto> tags = [];
   FBallInsertReqDto();
   factory FBallInsertReqDto.fromJson(Map<String, dynamic> json) => _$FBallInsertReqDtoFromJson(json);
   Map<String, dynamic> toJson() => _$FBallInsertReqDtoToJson(this);

}