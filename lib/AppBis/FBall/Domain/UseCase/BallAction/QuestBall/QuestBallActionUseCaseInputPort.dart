
import 'package:forutonafront/AppBis/FBall/Domain/Repository/BallAction/QuestBall/QuestBallActionRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateAcceptReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/RecruitParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:injectable/injectable.dart';

abstract class QuestBallActionUseCaseInputPort {
  Future<FBallResDto> recruitParticipants(RecruitParticipantReqDto reqDto);
  Future<ParticipantResDto> participate(ParticipantReqDto reqDto);
  Future<QuestBallParticipantResDto> getParticipate(String ballUuid);
  Future<List<QuestBallParticipantResDto>> getParticipates(String ballUuid,QuestBallParticipateState questBallParticipateState);
  Future<QuestEnterUserMode> getQuestEnterUserMode(FBallResDto fBallResDto);
  Future<void> participateAccept(QuestParticipateAcceptReqDto reqDto);
}

@LazySingleton(as: QuestBallActionUseCaseInputPort)
class QuestBallActionUseCase implements QuestBallActionUseCaseInputPort{

  final QuestBallActionRepository questBallActionRepository;

  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;

  QuestBallActionUseCase({required this.questBallActionRepository,required this.signInUserInfoUseCaseInputPort});

  @override
  Future<FBallResDto> recruitParticipants(RecruitParticipantReqDto reqDto) async {
    return await questBallActionRepository.recruitParticipants(reqDto);
  }

  Future<ParticipantResDto> participate(ParticipantReqDto reqDto) async {
    return await questBallActionRepository.participate(reqDto);
  }

  @override
  Future<QuestBallParticipantResDto> getParticipate(String ballUuid) async {
    return await questBallActionRepository.getParticipate(ballUuid);
  }

  @override
  Future<List<QuestBallParticipantResDto>> getParticipates(String ballUuid, QuestBallParticipateState state) async {
    return await questBallActionRepository.getParticipates(ballUuid,state);
  }

  Future<void> participateAccept(QuestParticipateAcceptReqDto reqDto) async {
    await questBallActionRepository.participateAccept(reqDto);
  }

  Future<QuestEnterUserMode> getQuestEnterUserMode(FBallResDto fBallResDto) async {
    QuestEnterUserMode questEnterUserMode;
    if (!signInUserInfoUseCaseInputPort.isLogin!) {
      questEnterUserMode = QuestEnterUserMode.NoneLogin;
    } else if (fBallResDto.uid!.uid ==
        signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid) {
      questEnterUserMode = QuestEnterUserMode.Maker;
    } else {
      questEnterUserMode = QuestEnterUserMode.Participant;
    }
    return questEnterUserMode;
  }

}