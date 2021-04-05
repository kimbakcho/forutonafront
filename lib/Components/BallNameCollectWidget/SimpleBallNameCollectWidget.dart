import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionTopTitleWidget.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionWidget.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpFromSearchTitle.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class SimpleBallNameCollectWidget extends StatelessWidget {
  final String searchText;
  final SimpleBallNameCollectListener simpleBallNameCollectListener;

  const SimpleBallNameCollectWidget(
      {Key key, this.searchText, this.simpleBallNameCollectListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SimpleBallNameCollectWidgetViewModel(
            ballListMediator: BallListMediatorImpl(),
            searchText: searchText,
            geoLocationUtilForeGroundUseCase: sl(),
            simpleBallNameCollectListener: simpleBallNameCollectListener),
        child: Consumer<SimpleBallNameCollectWidgetViewModel>(
            builder: (_, model, __) {
          return Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: SimpleCollectionWidget(
                titleDescription: "제목과 연관된 컨텐츠",
                searchCollectMediator: model.ballListMediator,
                simpleCollectionTopNextPageListener: model,
                searchText: searchText,
                indexedWidgetBuilder: model.getIndexedWidgetBuilder(),
              ));
        }));
  }
}

class SimpleBallNameCollectWidgetViewModel extends ChangeNotifier
    implements SimpleCollectionTopNextPageListener {
  final BallListMediator ballListMediator;
  final String searchText;
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCase;
  final SimpleBallNameCollectListener simpleBallNameCollectListener;

  SimpleBallNameCollectWidgetViewModel(
      {@required this.ballListMediator,
      @required this.searchText,
      @required this.geoLocationUtilForeGroundUseCase,
      @required this.simpleBallNameCollectListener}) {
    var lastPosition =
        geoLocationUtilForeGroundUseCase.getCurrentWithLastPositionInMemory();
    ballListMediator.pageLimit = 5;
    ballListMediator.fBallListUpUseCaseInputPort = FBallListUpFromSearchTitle(
        FBallListUpFromSearchTitleReqDto(
          searchText: searchText,
          latitude: lastPosition.latitude,
          longitude: lastPosition.longitude,
        ),
        fBallRepository: sl());
  }

  @override
  void onNextPage(String searchText) {
    if (simpleBallNameCollectListener != null) {
      simpleBallNameCollectListener.onSimpleBallNameCollectNextPage(searchText);
    }
  }

  IndexedWidgetBuilder getIndexedWidgetBuilder() {
    return (_, index) {
      return Container(
        child: ListUpBallWidgetFactory.getBallWidget(
            index, ballListMediator, BallStyle.Style2,
            boxDecoration: BoxDecoration(
                border: Border.all(color: Color(0xffE4E7E8)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
      );
    };
  }
}

abstract class SimpleBallNameCollectListener {
  void onSimpleBallNameCollectNextPage(String searchText);
}
