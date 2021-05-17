
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'QuestBallParticipantResDto.g.dart';

@JsonSerializable()
class QuestBallParticipantResDto {
  int? idx;

  String? ballUuid;

  FUserInfoSimpleResDto? uid;

  DateTime? participationTime;

  String? photoShotForCertificationImage;

  double? checkInPositionLat;

  double? checkInPositionLng;

  double? startPositionLat;

  double? startPositionLng;

  int? likePoint;

  int? dislikePoint;

  QuestBallParticipateState? currentState;

  QuestBallParticipantResDto();

  factory QuestBallParticipantResDto.fromJson(Map<String, dynamic> json) => _$QuestBallParticipantResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$QuestBallParticipantResDtoToJson(this);
}