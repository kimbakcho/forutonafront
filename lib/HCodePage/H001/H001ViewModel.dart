import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/ListUpBallListUpOrderByBI.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/NoInterestedBallDecorator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

class H001ViewModel
    with ChangeNotifier
    implements GeoViewSearchListener, BallListMediatorComponent {
  final GeoLocationUtilBasicUseCaseInputPort
      geoLocationUtilBasicUseCaseInputPort;
  final BallListMediator ballListMediator;
  final GeoViewSearchManagerInputPort geoViewSearchManager;
  final FBallRepository fBallRepository;
  final RankingTagListMediator rankingTagListFromBIManager;
  final NoInterestBallUseCaseInputPort noInterestBallUseCaseInputPort;
  final TagRepository tagRepository;

  FluttertoastAdapter fluttertoastAdapter = sl();

  H001ViewModel(
      {this.geoViewSearchManager,
      this.fBallRepository,
      this.rankingTagListFromBIManager,
      this.ballListMediator,
      this.geoLocationUtilBasicUseCaseInputPort,
      this.noInterestBallUseCaseInputPort,
      this.tagRepository}) {
    ballListMediator.registerComponent(this);
    geoViewSearchManager.subscribe(this);
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    geoViewSearchManager.unSubscribe(this);
    super.dispose();
  }

  @override
  Future<void> search(Position loadPosition,double zoomLevel) async {
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

    await ballListMediator.searchFirst();

    await rankingTagListFromBIManager.search(loadPosition);

  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }

  @override
  void onBallListEmpty() {

  }
}
