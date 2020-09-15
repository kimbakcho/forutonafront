import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpFromInfluencePower.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';


class H001ViewModel
    with ChangeNotifier {
  final BuildContext context;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilUseCaseInputPort;


  Position _currentSearchPosition;

  bool _subScrollerTopOver = false;


  ScrollController h001CenterListViewController = new ScrollController();

  List<BallStyle1Widget> ballWidgetLists = [];

  bool isLoading = false;

  final BallListMediator _influencePowerBallListMediator;

  H001ViewModel(
      {@required
          this.context,
      BallListMediator influencePowerBallListMediator,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilUseCaseInputPort})
      : _influencePowerBallListMediator = influencePowerBallListMediator,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    h001CenterListViewController
        .addListener(this.h001CenterListViewControllerListener);

    init();
  }

  List<FBallResDto> get ballList {
    return _influencePowerBallListMediator.ballList;
  }

  void init() async {

    await _geoLocationUtilUseCaseInputPort.useGpsReq();

    _currentSearchPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

    _influencePowerBallListMediator.pageLimit = 999;

    _searchFBallFromBallInfluencePowerWithCurrentSearchPosition(
        firstPage: true);

  }



  Future<String> getCurrentSearchPositionAddress() async {
    return await _geoLocationUtilUseCaseInputPort.getPositionAddress(Position(
        latitude: _currentSearchPosition.latitude,
        longitude: _currentSearchPosition.longitude));
  }

  Future _searchFBallFromBallInfluencePowerWithCurrentSearchPosition(
      {bool firstPage = false}) async {

    FBallListUpFromBallInfluencePowerReqDto reqDto =
        FBallListUpFromBallInfluencePowerReqDto(
            latitude: _currentSearchPosition.latitude,
            longitude: _currentSearchPosition.longitude);

    _influencePowerBallListMediator.fBallListUpUseCaseInputPort =
        FBallListUpFromInfluencePower(
            fBallRepository: sl(), listUpReqDto: reqDto);
    if (firstPage) {
      await _influencePowerBallListMediator.searchFirst();
    } else {
      await _influencePowerBallListMediator.searchNext();
    }

  }

  h001CenterListViewControllerListener() async {

    if (_isScrollerBottomOver()) {
      // _scrollerOver();
    }
    if (_isScrollerTopOver()) {
      _scrollerTopOver();
    }
  }

  bool _isScrollerTopOver() {
    if (h001CenterListViewController.offset <=
        h001CenterListViewController.position.minScrollExtent - 100) {
      _subScrollerTopOver = true;
    }
    if (_subScrollerTopOver &&
        !h001CenterListViewController.position.outOfRange) {
      _subScrollerTopOver = false;
      return true;
    } else {
      return false;
    }
  }

  void _scrollerTopOver() async {
    await searchFirstPage();
  }

  Future searchFirstPage() async {
    await _searchFBallFromBallInfluencePowerWithCurrentSearchPosition();
  }

  bool _isScrollerBottomOver() {
    return h001CenterListViewController.offset >=
            h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange;
  }

  void moveDetailPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DetailPageViewer(
        ballListMediator: _influencePowerBallListMediator,
        detailPageItemFactory: sl(),
        initIndex: index,
      );
    }));
  }
}
