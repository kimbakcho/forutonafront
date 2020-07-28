import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/Tag/Dto/TagInsertReqDto.dart';
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

  factory FBallInsertReqDto.fromIssueBall(IssueBall issueBall){
    FBallInsertReqDto issueBallInsertReqDto = FBallInsertReqDto();
    issueBallInsertReqDto.ballUuid = issueBall.ballUuid;
    issueBallInsertReqDto.longitude = issueBall.longitude;
    issueBallInsertReqDto.latitude = issueBall.latitude;
    issueBallInsertReqDto.ballName = issueBall.ballName;
    issueBallInsertReqDto.ballType = issueBall.ballType;
    issueBallInsertReqDto.placeAddress = issueBall.placeAddress;
    issueBallInsertReqDto.description = issueBall.description;
    issueBallInsertReqDto.tags = issueBall.tags.map((x) => TagInsertReqDto.fromFBallTag(x)).toList();
    return issueBallInsertReqDto;
  }
}