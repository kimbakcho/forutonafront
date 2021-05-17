
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01002Sheet/QuestSelectMode.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDescription.dart';

part 'QuestBallDescription.g.dart';

@JsonSerializable()
class QuestBallDescription extends BallDescription {

  QuestSelectMode? successSelectMode;
  double? checkInPositionLat;
  double? checkInPositionLong;
  String? checkInAddress;
  String? photoCertificationDescription;
  int? limitTimeSec;
  double? startPositionLat;
  double? startPositionLong;
  String? startPositionAddress;
  bool? timeLimitFlag;
  bool? startPositionFlag;
  bool? isOpenCheckInPosition;
  String? qualifyingForQuestText;


  QuestBallDescription();
  factory QuestBallDescription.fromJson(Map<String, dynamic> json) => _$QuestBallDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestBallDescriptionToJson(this);


}