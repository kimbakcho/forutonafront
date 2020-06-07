import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/Tag/Dto/TagInsertReqDto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'IssueBallUpdateReqDto.g.dart';

@JsonSerializable()
class IssueBallUpdateReqDto {
   String ballUuid;
   double longitude;
   double latitude;
   String ballName;
   FBallType ballType;
   String placeAddress;
   String description;
   List<TagInsertReqDto> tags;
   IssueBallUpdateReqDto();
   factory IssueBallUpdateReqDto.fromJson(Map<String, dynamic> json) => _$IssueBallUpdateReqDtoFromJson(json);
   Map<String, dynamic> toJson() => _$IssueBallUpdateReqDtoToJson(this);

   factory IssueBallUpdateReqDto.fromIssueBall(IssueBall issueBall){
      IssueBallUpdateReqDto issueBallUpdateReqDto = IssueBallUpdateReqDto();
      issueBallUpdateReqDto.ballUuid = issueBall.ballUuid;
      issueBallUpdateReqDto.longitude = issueBall.longitude;
      issueBallUpdateReqDto.latitude = issueBall.latitude;
      issueBallUpdateReqDto.ballName = issueBall.ballName;
      issueBallUpdateReqDto.ballType = issueBall.ballType;
      issueBallUpdateReqDto.placeAddress = issueBall.placeAddress;
      issueBallUpdateReqDto.description = issueBall.description;
      issueBallUpdateReqDto.tags = issueBall.tags.map((x) => TagInsertReqDto.fromFBallTag(x)).toList();
      return issueBallUpdateReqDto;
   }

}