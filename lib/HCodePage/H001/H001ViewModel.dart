import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/ListUpBallListUpOrderByBI.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class H001ViewModel with ChangeNotifier implements H001Listener {
  H001Manager _h001manager;
  RankingTagListFromBIManager rankingTagListFromBIManager;
  BallListMediator ballListMediator;
  GeoLocationUtilBasicUseCaseInputPort geoLocationUtilBasicUseCaseInputPort;

  H001ViewModel({
    @required this.ballListMediator,
    @required this.rankingTagListFromBIManager}) {
    _h001manager = sl();
    geoLocationUtilBasicUseCaseInputPort = sl();
    _h001manager.subscribe(this);
  }

  @override
  void dispose() {
    _h001manager.unSubscribe(this);
    super.dispose();
  }

  @override
  Future<void> search(Position loadPosition) async {
    var userPosition = await geoLocationUtilBasicUseCaseInputPort.getCurrentWithLastPosition();

    ballListMediator.fBallListUpUseCaseInputPort = ListUpBallListUpOrderByBI(
      fBallRepository: sl(),
      listUpReqDto: FBallListUpFromBIReqDto(
        mapCenterLatitude: loadPosition.latitude,
        mapCenterLongitude: loadPosition.longitude,
        userLongitude: userPosition.longitude,
        userLatitude: userPosition.latitude
      )
    );

    await rankingTagListFromBIManager.search(loadPosition);
    await ballListMediator.searchFirst();
  }
}
