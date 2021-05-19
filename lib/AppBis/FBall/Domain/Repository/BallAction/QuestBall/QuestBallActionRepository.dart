

import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateAcceptReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateDeniedReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/RecruitParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

abstract class QuestBallActionRepository {
  Future<FBallResDto> recruitParticipants(RecruitParticipantReqDto reqDto);

  Future<ParticipantResDto> participate(ParticipantReqDto reqDto);

  Future<QuestBallParticipantResDto> getParticipate(String ballUuid);

  Future<List<QuestBallParticipantResDto>> getParticipates(String ballUuid, QuestBallParticipateState state);

  Future<void> participateAccept(QuestParticipateAcceptReqDto reqDto);

  Future<void> participateDenied(QuestParticipateDeniedReqDto reqDto);

  Future<int> countByBallUuidAndCurrentState(String ballUuid, QuestBallParticipateState questBallParticipateState);

}