import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FBallValuationRepository)
class FBallValuationRepositoryImpl implements FBallValuationRepository {
  final FireBaseAuthAdapterForUseCase _fireBaseAuthBaseAdapter;

  FBallValuationRepositoryImpl(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter})
      : _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  @override
  Future<FBallVoteResDto> ballVote(FBallVoteReqDto reqDto) async {
    var fDio = FDio.token(
        idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response =
        await fDio.post("/v1/FBallValuation/BallVote", data: reqDto.toJson());
    return FBallVoteResDto.fromJson(response.data);
  }

  @override
  Future<FBallVoteResDto> findByBallVoteState(String ballUuid) async {
    var fDio = FDio.token(
        idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.get("/v1/FBallValuation/BallVote",
        queryParameters: {"ballUuid": ballUuid});
    return FBallVoteResDto.fromJson(response.data);
  }
}
