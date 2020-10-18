import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionTopTitleWidget.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionWidget.dart';
import 'package:forutonafront/Components/TagContainBallCollectWidget/TagContainBallCollectMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagNameItemListUpUseCase.dart';
import 'package:forutonafront/Tag/Dto/TextMatchTagBallReqDto.dart';
import 'package:provider/provider.dart';

class TagContainBallCollectWidget extends StatelessWidget {
  final String searchText;
  final TagContainBallCollectListener tagContainBallCollectListener;

  const TagContainBallCollectWidget(
      {Key key, this.searchText, this.tagContainBallCollectListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TagContainBallCollectWidgetViewModel(
            ballListMediator: TagContainBallCollectMediator(),
            searchText: searchText,
            geoLocationUtilForeGroundUseCase: sl(),
            tagContainBallCollectListener: tagContainBallCollectListener),
        child: Consumer<TagContainBallCollectWidgetViewModel>(
            builder: (_, model, __) {
          return Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: SimpleCollectionWidget(
                searchText: searchText,
                searchCollectMediator: model.ballListMediator,
                indexedWidgetBuilder: model.getIndexedWidgetBuilder(),
                simpleCollectionTopNextPageListener: model,
                titleDescription: "태그와 연관된 컨텐츠",
              ));
        }));
  }
}

class TagContainBallCollectWidgetViewModel extends ChangeNotifier
    implements SimpleCollectionTopNextPageListener {
  final BallListMediator ballListMediator;
  final String searchText;
  final TagContainBallCollectListener tagContainBallCollectListener;
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCase;

  TagContainBallCollectWidgetViewModel(
      {@required this.searchText,
      @required this.ballListMediator,
      @required this.tagContainBallCollectListener,
      @required this.geoLocationUtilForeGroundUseCase}) {
    var searchPosition =
        geoLocationUtilForeGroundUseCase.getCurrentWithLastPositionInMemory();
    ballListMediator.fBallListUpUseCaseInputPort = TagNameItemListUpUseCase(
        tagRepository: sl(),
        reqDto: TextMatchTagBallReqDto(
            searchText: searchText,
            mapCenterLongitude: searchPosition.longitude,
            mapCenterLatitude: searchPosition.latitude));
  }

  IndexedWidgetBuilder getIndexedWidgetBuilder() {
    return (_, index) {
      return ListUpBallWidgetFactory.getBallWidget(
          index, ballListMediator, BallStyle.Style3,
          boxDecoration: BoxDecoration(color: Colors.white));
    };
  }

  @override
  void onNextPage(String searchText) {
    tagContainBallCollectListener.onTagContainBallCollectNextPage(searchText);
  }
}

abstract class TagContainBallCollectListener {
  void onTagContainBallCollectNextPage(String searchText);
}
