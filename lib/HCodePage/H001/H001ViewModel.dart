import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:geolocator/geolocator.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier {
  H001PageState _currentState;
  String _selectPosition = "로 딩 중";
  TagRankingWrapDto _rankingWrapDto;
  SwiperController rankingSwiperController = new SwiperController();
  bool rankingAutoPlay = false;
  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  bool hasBall = true;

  TagRankingRepository _tagRankingRepository = new TagRankingRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();
  ScrollController h001CenterListViewController = new ScrollController();

  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;

  FBallRepository _fBallRepository = new FBallRepository();
  FBallListUpWrapDto _fBallListUpWrapDto =
      new FBallListUpWrapDto(DateTime.now(), []);

  H001ViewModel() {
    _currentState = H001PageState.H001_01;
    _rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    init();
  }

  init() async {
    await getCurrentPositionFromGeoLocation();
    var currentPosition =
        await _geolocationRepository.getCurrentPhoneLocation();
    getTagRanking(currentPosition);
    _fBallListUpWrapDto = new FBallListUpWrapDto(DateTime.now(), []);
    getBallListUp(currentPosition, _pageCount, _ballPageLimitSize);
    _pageCount = 0;
    notifyListeners();
  }

  Future getBallListUp(Position currentPosition, int page, int size) async {
    FBallListUpReqDto ballListUpReqDto = new FBallListUpReqDto(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        ballLimit: 1000,
        page: page,
        size: size,
        sort: "Influence,DESC");
    var fBallListUpWrapDtoTemp =
        await _fBallRepository.listUpBall(ballListUpReqDto);
    _fBallListUpWrapDto.searchTime = fBallListUpWrapDtoTemp.searchTime;
    _fBallListUpWrapDto.balls.addAll(fBallListUpWrapDtoTemp.balls);
    if(_fBallListUpWrapDto.balls.length == 0){
      hasBall = false;
    }else {
      hasBall = true;
    }
    notifyListeners();
  }

  Future getTagRanking(Position currentPosition) async {
    _rankingWrapDto = await _tagRankingRepository.getTagRanking(
        new TagRankingReqDto(
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

    /**
     * 맨 밑으로 왔을때 무한 스크롤을 위한 이벤트 처리
     */
    if (h001CenterListViewController.offset >=
            h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange) {
      _pageCount++;
      if (_pageCount * _ballPageLimitSize >
          this.fBallListUpWrapDto.balls.length) {
        return;
      } else {
        var currentPosition =
            await _geolocationRepository.getCurrentPhoneLocation();
        getBallListUp(currentPosition, _pageCount, _ballPageLimitSize);
      }
    }
  }

  getCurrentPositionFromGeoLocation() async {
    _selectPosition = await _geolocationRepository.getCurrentPhoneAddress();
    notifyListeners();
    return _selectPosition;
  }

  bool get inlineRanking => _inlineRanking;

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  TagRankingWrapDto get rankingWrapDto => _rankingWrapDto;

  set rankingWrapDto(TagRankingWrapDto value) {
    _rankingWrapDto = value;
  }

  String get selectPosition => _selectPosition;

  set selectPosition(String value) {
    _selectPosition = value;
  }

  H001PageState get currentState => _currentState;

  set currentState(H001PageState value) {
    _currentState = value;
  }

  GeolocationRepository get geolocationRepository => _geolocationRepository;

  set geolocationRepository(GeolocationRepository value) {
    _geolocationRepository = value;
  }

  FBallListUpWrapDto get fBallListUpWrapDto => _fBallListUpWrapDto;

  set fBallListUpWrapDto(FBallListUpWrapDto value) {
    _fBallListUpWrapDto = value;
  }
}
