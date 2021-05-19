import 'package:enum_to_string/enum_to_string.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/BallAction/QuestBall/QuestBallActionRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/ParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateAcceptReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestParticipateDeniedReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/RecruitParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Preference.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: QuestBallActionRepository)
class QuestBallActionRepositoryImpl implements QuestBallActionRepository {
  final FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter;

  QuestBallActionRepositoryImpl({required this.fireBaseAuthBaseAdapter});

  @override
  Future<FBallResDto> recruitParticipants(
      RecruitParticipantReqDto reqDto) async {
    var fDio =
        FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.post(
        "${Preference.baseBackEndUrl}/QuestBall/RecruitParticipant",
        data: reqDto);
    return FBallResDto.fromJson(response.data);
  }

  @override
  Future<ParticipantResDto> participate(ParticipantReqDto reqDto) async {
    var fDio =
        FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.post(
        "${Preference.baseBackEndUrl}/QuestBall/Participate",
        data: reqDto);
    return ParticipantResDto.fromJson(response.data);
  }

  @override
  Future<QuestBallParticipantResDto> getParticipate(String ballUuid) async {
    var fDio =
        FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.get(
        "${Preference.baseBackEndUrl}/QuestBall/Participate",
        queryParameters: {"ballUuid": ballUuid});
    return QuestBallParticipantResDto.fromJson(response.data);
  }

  @override
  Future<List<QuestBallParticipantResDto>> getParticipates(
      String ballUuid, QuestBallParticipateState state) async {
    var fDio =
        FDio.noneToken();

    var response = await fDio.get(
        "${Preference.baseBackEndUrl}/QuestBall/Participates",
        queryParameters: {
          "ballUuid": ballUuid,
          "state": EnumToString.convertToString(state)
        });

    return List<QuestBallParticipantResDto>.from(
        response.data.map((x) => QuestBallParticipantResDto.fromJson(x)));
  }

  @override
  Future<void> participateAccept(QuestParticipateAcceptReqDto reqDto) async {
    var fDio = FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    await fDio.post("${Preference.baseBackEndUrl}/QuestBall/ParticipateAccept",data: reqDto);
  }

  @override
  Future<void> participateDenied(QuestParticipateDeniedReqDto reqDto) async {
    var fDio = FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    await fDio.post("${Preference.baseBackEndUrl}/QuestBall/ParticipateDenied",data: reqDto);
  }

  @override
  Future<int> countByBallUuidAndCurrentState(String ballUuid, QuestBallParticipateState state) async {
    var fDio = FDio.noneToken();
    var response = await fDio.get(
        "${Preference.baseBackEndUrl}/QuestBall/StateParticipatesCount",
        queryParameters: {
          "ballUuid": ballUuid,
          "state": EnumToString.convertToString(state)
        });
    return response.data;
  }
}
