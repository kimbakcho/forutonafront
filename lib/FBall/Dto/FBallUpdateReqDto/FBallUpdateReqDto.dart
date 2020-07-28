import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/Tag/Dto/TagInsertReqDto.dart';
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

  factory FBallUpdateReqDto.fromIssueBall(IssueBall issueBall){
    FBallUpdateReqDto issueBallUpdateReqDto = FBallUpdateReqDto();
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