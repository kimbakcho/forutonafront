
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'FBallState.dart';
import 'FBallType.dart';
part 'FBallReqDto.g.dart';
@JsonSerializable()
class FBallReqDto {
  FBallReqDto(this.uid, this.cubeUuid, this.longitude, this.latitude,
      this.matchBallName, this.fBallType, this.makeTime, this.fBallState,
      this.page);
  String uid;
  String cubeUuid;
  double longitude;
  double latitude;
  String matchBallName;
  FBallType fBallType;
  DateTime makeTime;
  FBallState fBallState;
  Pageable page;

  factory FBallReqDto.fromJson(Map<String, dynamic> json) => _$FBallReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallReqDtoToJson(this);


}