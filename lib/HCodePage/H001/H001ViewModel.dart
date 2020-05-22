import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingWrapDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetInter.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier implements  BallStyle1WidgetInter{
  final BuildContext _context;
  H001PageState currentState;
  String selectPositionAddress = "로 딩 중";
  bool rankingAutoPlay = false;
  bool hasBall = true;
  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();
  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;
  TagRankingWrapDto rankingWrapDto;
  String listViewKey = Uuid().v4();

//  FBallListUpWrapDto fBallListUpWrapDto =
//      new FBallListUpWrapDto(DateTime.now(), []);

  List<BallStyle1Widget> ballWidgetLists = [];

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Position _currentPosition;
  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;

  H001ViewModel(this._context) {
    init();
  }

  init() async {
    GeoLocationUtil _geoLocationUtil = new GeoLocationUtil();
    currentState = H001PageState.H001_01;
    rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    _setIsLoading(true);
    await _geoLocationUtil.permissionCheck();
    if (await _geoLocationUtil.permissionCheck()) {
      _currentPosition = await Geolocator().getCurrentPosition();
      await reFreshSearchBall(_currentPosition);
    }
    _setIsLoading(false);
  }

  moveToH007() async {
    ///Navigator 는 검색 위치로 지정한 LatLng 이 나온다.
    MapSearchGeoDto position = await Navigator.of(_context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "H007"),
            builder: (context) =>
                H007MainPage(_currentPosition, selectPositionAddress)));
    if (position != null) {
      _currentPosition = Position(
          latitude: position.latLng.latitude,
          longitude: position.latLng.longitude);
      _setIsLoading(true);
      await reFreshSearchBall(_currentPosition,
          address: position.descriptionAddress);
      _setIsLoading(false);
    }
  }

  Future reFreshSearchBall(Position serachPosition, {String address}) async {
    if (address == null) {
      selectPositionAddress = "로 딩 중";
      notifyListeners();
      selectPositionAddress = await getAddressFromGeoLocation(serachPosition);
    } else {
      selectPositionAddress = address;
    }
    getTagRanking(serachPosition);

    _pageCount = 0;
    getBallListUp(serachPosition, _pageCount, _ballPageLimitSize);
  }

  Future getBallListUp(Position currentPosition, int page, int size) async {
    FBallRepository _fBallRepository = new FBallRepository();
    FBallListUpReqDto ballListUpReqDto = new FBallListUpReqDto(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        ballLimit: 1000,
        page: page,
        size: size,
        sort: "Influence,DESC");
    var fBallListUpWrapDtoTemp =
        await _fBallRepository.listUpBall(ballListUpReqDto);

    if (page == 0) {
      this.ballWidgetLists.clear();
    }

    this.ballWidgetLists.addAll(fBallListUpWrapDtoTemp.balls
        .map((x) => BallStyle1Widget.create(x.ballType,BallStyle1WidgetController(x,this)))
        .toList());

//    reRenderListView();

    if (this.ballWidgetLists.length == 0) {
      hasBall = false;
      addressDisplayShowFlag = true;
    } else {
      hasBall = true;
    }
    notifyListeners();
  }

  Future getTagRanking(Position currentPosition) async {
    TagRepository _tagRepository = new TagRepository();
    rankingWrapDto = await _tagRepository.getTagRanking(new TagRankingReqDto(
        currentPosition.latitude, currentPosition.longitude, 10));
    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

  h001CenterListViewControllerListener() async {
    if (h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.forward) {
      addressDisplayShowFlag = true;
      makeButtonDisplayShowFlag = true;
      notifyListeners();
    } else if (h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      addressDisplayShowFlag = false;
      makeButtonDisplayShowFlag = false;
      notifyListeners();
    }

    if (_isScrollerBottomOver()) {
      _pageCount++;
      if (!_hasMoreListUpBalls()) {
        return;
      } else {
        _setIsLoading(true);
        await getBallListUp(_currentPosition, _pageCount, _ballPageLimitSize);
        _setIsLoading(false);
      }
    }
  }

  bool _hasMoreListUpBalls() {
    return !(_pageCount * _ballPageLimitSize >
        this.ballWidgetLists.length);
  }

  bool _isScrollerBottomOver() {
    return h001CenterListViewController.offset >=
            h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange;
  }

  Future<String> getAddressFromGeoLocation(Position reqPosition) async {
    GeolocationRepository _geolocationRepository = GeolocationRepository();
    var address = await _geolocationRepository.getPositionAddress(reqPosition);
    notifyListeners();
    return address;
  }

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  isFoldTagRanking() {
    return _inlineRanking;
  }

  void goBallMakePage() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null) {
      await Navigator.push(
          _context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/H002"),
              builder: (context) {
                return H002Page(
                  heroTag: "H001MakeButton",
                );
              }));
      _currentPosition = await Geolocator().getCurrentPosition();
      _setIsLoading(true);
      await reFreshSearchBall(_currentPosition);
      _setIsLoading(false);
    } else {
      Navigator.push(
          _context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/J001"),
              builder: (context) {
                return J001View();
              }));
    }
  }

  @override
  onRequestReFreshBall(FBallResDto reFreshNeedBall) async {
    _setIsLoading(true);
    var ballStyle1ReFreshBallUtil = BallStyle1ReFreshBallUtil();
    await ballStyle1ReFreshBallUtil.reFreshBallAndUiUpdate(ballWidgetLists, reFreshNeedBall, this);
    _setIsLoading(false);
  }
}
