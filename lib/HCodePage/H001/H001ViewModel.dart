import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/ListUpBallListUpOrderByBI.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/NoInterestedBallDecorator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'H001Manager.dart';

class H001ViewModel
    with ChangeNotifier
    implements H001Listener, BallListMediatorComponent {
  final GeoLocationUtilBasicUseCaseInputPort
      geoLocationUtilBasicUseCaseInputPort;
  final BallListMediator ballListMediator;
  final H001ManagerInputPort h001manager;
  final FBallRepository fBallRepository;
  final RankingTagListMediator rankingTagListFromBIManager;
  final NoInterestBallUseCaseInputPort noInterestBallUseCaseInputPort;
  final TagRepository tagRepository;

  H001ViewModel(
      {this.h001manager,
      this.fBallRepository,
      this.rankingTagListFromBIManager,
      this.ballListMediator,
      this.geoLocationUtilBasicUseCaseInputPort,
      this.noInterestBallUseCaseInputPort,
      this.tagRepository}) {
    ballListMediator.registerComponent(this);
    h001manager.subscribe(this);
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    h001manager.unSubscribe(this);
    super.dispose();
  }

  @override
  Future<void> search(Position loadPosition) async {
    ballListMediator.fBallListUpUseCaseInputPort = NoInterestedBallDecorator(
        noInterestBallUseCaseInputPort: noInterestBallUseCaseInputPort,
        fBallListUpUseCaseInputPort: ListUpBallListUpOrderByBI(
            fBallRepository: fBallRepository,
            listUpReqDto: FBallListUpFromBIReqDto(
              mapCenterLatitude: loadPosition.latitude,
              mapCenterLongitude: loadPosition.longitude,
            )));

    rankingTagListFromBIManager.tagRankingUseCaseInputPort =
        TagRankingFromBallInfluencePowerUseCase(
            tagRepository: tagRepository,
            reqDto: TagRankingFromBallInfluencePowerReqDto(
                mapCenterLongitude: loadPosition.longitude,
                mapCenterLatitude: loadPosition.latitude));

    await rankingTagListFromBIManager.search(loadPosition);

    await ballListMediator.searchFirst();
  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }
}
