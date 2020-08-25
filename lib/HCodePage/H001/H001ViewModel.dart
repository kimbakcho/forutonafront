import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/Components/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpFromInfluencePower.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel
    with ChangeNotifier
    implements
        TagRankingFromBallInfluencePowerUseCaseOutputPort {
  final BuildContext context;

  final TagRankingFromBallInfluencePowerUseCaseInputPort
      _tagRankingFromPositionUseCaseInputPort;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilUseCaseInputPort;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  Position _currentSearchPosition;
  String _currentSearchAddress;

  bool _subScrollerTopOver = false;

  String selectPositionAddress = "";

  bool rankingAutoPlay = false;

  SwiperController rankingSwiperController = new SwiperController();

  ScrollController h001CenterListViewController = new ScrollController();

  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;

  List<BallStyle1Widget> ballWidgetLists = [];

  bool _inlineRanking = true;

  bool isLoading = false;

  List<TagRankingResDto> tagRankingDtos = [];

  bool isInitFinish = false;

  final BallListMediator _influencePowerBallListMediator;

  H001ViewModel(
      {@required
          this.context,
      BallListMediator influencePowerBallListMediator,
      @required
          TagRankingFromBallInfluencePowerUseCaseInputPort
              tagRankingFromPositionUseCaseInputPort,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilUseCaseInputPort})
      : _influencePowerBallListMediator = influencePowerBallListMediator,
        _tagRankingFromPositionUseCaseInputPort =
            tagRankingFromPositionUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    h001CenterListViewController
        .addListener(this.h001CenterListViewControllerListener);

    init();
  }

  List<FBallResDto> get ballList {
    return _influencePowerBallListMediator.ballList;
  }

  void init() async {
    showLoading();

    setDisplayAddressText("로딩중");

    await _geoLocationUtilUseCaseInputPort.useGpsReq();

    _currentSearchPosition =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();

    _currentSearchAddress = await getCurrentSearchPositionAddress();

    setDisplayAddressText(_currentSearchAddress);

    showAddressDisplay();

    _influencePowerBallListMediator.pageLimit = 999;

    _searchFBallFromBallInfluencePowerWithCurrentSearchPosition(
        firstPage: true);

    _searchTagRankingFromBallInfluencePowerWithCurrentSearchPosition();

    initFinish();

    hideLoading();
  }

  void initFinish() {
    isInitFinish = true;
    notifyListeners();
  }

  Future<void>
      _searchTagRankingFromBallInfluencePowerWithCurrentSearchPosition() async {
    await _tagRankingFromPositionUseCaseInputPort
        .reqTagRankingFromBallInfluencePower(
            TagRankingFromBallInfluencePowerReqDto(
                position: _currentSearchPosition, limit: 10),
            this);
  }

  @override
  void onTagRankingFromBallInfluencePower(
      List<TagRankingResDto> tagRankingDtos) {
    this.tagRankingDtos = tagRankingDtos;
    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

  Future<String> getCurrentSearchPositionAddress() async {
    return await _geoLocationUtilUseCaseInputPort.getPositionAddress(Position(
        latitude: _currentSearchPosition.latitude,
        longitude: _currentSearchPosition.longitude));
  }

  Future _searchFBallFromBallInfluencePowerWithCurrentSearchPosition(
      {bool firstPage = false}) async {
    showLoading();

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

    hideLoading();
  }

  h001CenterListViewControllerListener() async {
    if (_isUserScrollerForward()) {
      _showAddressWithMakeBtn();
    }
    if (_isUserScrollerReverse()) {
      _hideAddressWithMakeBtn();
    }

    if (_isScrollerBottomOver()) {
      _scrollerOver();
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

  moveToH007() async {
    MapSearchGeoDto position = await gotoH007Page();
    if (isNoneSelectPosition(position)) {
      _currentSearchPosition = Position(
          latitude: position.latLng.latitude,
          longitude: position.latLng.longitude);

      await _searchFBallFromBallInfluencePowerWithCurrentSearchPosition();
      await _searchTagRankingFromBallInfluencePowerWithCurrentSearchPosition();

      showAddressDisplay();

      setDisplayAddressText(position.descriptionAddress);
    }
  }

  bool isNoneSelectPosition(MapSearchGeoDto position) => position != null;

  Future<MapSearchGeoDto> gotoH007Page() async {
    return await Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "H007"),
        builder: (context) =>
            H007MainPage(_currentSearchPosition, _currentSearchAddress)));
  }

  bool _isScrollerBottomOver() {
    return h001CenterListViewController.offset >=
            h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange;
  }

  void _scrollerOver() async {
    await _searchFBallFromBallInfluencePowerWithCurrentSearchPosition();
    moveScrollerDown();
  }

  bool _isUserScrollerForward() {
    return h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.forward;
  }

  bool _isUserScrollerReverse() {
    return h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.reverse;
  }

  void _showAddressWithMakeBtn() {
    showAddressDisplay();
    showMakeButtonDisplay();
  }

  void _hideAddressWithMakeBtn() {
    hiedAddressDisplay();
    hiedMakeButtonDisplay();
  }

  void goBallMakePage() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await gotoH002Page();
      _currentSearchPosition =
          await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
      await searchFirstPage();
    } else {
      gotoJ001Page();
    }
  }

  Future gotoJ001Page() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "/J001"),
            builder: (context) {
              return J001View();
            }));
  }

  Future gotoH002Page() async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "/H002"),
            builder: (context) {
              return H002Page(
                heroTag: "H001MakeButton",
              );
            }));
  }

  void gotoTagSearch(String tagName) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => H005MainPage(
            searchText: tagName, initPageState: H005PageState.Tag)));
  }

  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  ballClear() {
    this.ballWidgetLists.clear();
  }

  showAddressDisplay() {
    addressDisplayShowFlag = true;
    notifyListeners();
  }

  hiedAddressDisplay() {
    addressDisplayShowFlag = false;
    notifyListeners();
  }

  bool isBallEmpty() => this.ballWidgetLists.length == 0 && isInitFinish;

  void setDisplayAddressText(String address) {
    this.selectPositionAddress = address;
    notifyListeners();
  }

  Future<void> moveScrollerDown() {
    return h001CenterListViewController.animateTo(
        h001CenterListViewController.offset +
            (MediaQuery.of(context).size.height / 2),
        duration: Duration(milliseconds: 300),
        curve: Curves.linear);
  }

  showMakeButtonDisplay() {
    makeButtonDisplayShowFlag = true;
    notifyListeners();
  }

  hiedMakeButtonDisplay() {
    makeButtonDisplayShowFlag = false;
    notifyListeners();
  }

  void showUnInlineRankingWidget() {
    _inlineRanking = false;
    notifyListeners();
  }

  void showInlineRankingWidget() {
    _inlineRanking = true;
    notifyListeners();
  }

  get currentBallWidgetCount {
    return ballWidgetLists.length;
  }

  isFoldTagRanking() {
    return _inlineRanking;
  }

  String changeTagValueDisplay(double value) {
    return NomalValueDisplay.changeIntDisplaystr(value);
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
