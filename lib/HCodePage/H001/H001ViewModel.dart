import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingWrapDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier {
  H001PageState currentState;
  String selectPosition = "로 딩 중";
  bool rankingAutoPlay = false;
  bool _inlineRanking = true;
  int pageCount = 0;
  int ballPageLimitSize = 20;
  bool hasBall = true;

  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();

  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;

  TagRankingWrapDto rankingWrapDto;
  FBallListUpWrapDto fBallListUpWrapDto =
      new FBallListUpWrapDto(DateTime.now(), []);

  TagRepository _tagRepository = new TagRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();
  FBallRepository _fBallRepository = new FBallRepository();

  H001ViewModel() {
    currentState = H001PageState.H001_01;
    rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    init();
  }

  init() async {
    await getCurrentPositionFromGeoLocation();
    var currentPosition =
        await _geolocationRepository.getCurrentPhoneLocation();
    getTagRanking(currentPosition);
    fBallListUpWrapDto = new FBallListUpWrapDto(DateTime.now(), []);
    getBallListUp(currentPosition, pageCount, ballPageLimitSize);
    pageCount = 0;
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
    fBallListUpWrapDto.searchTime = fBallListUpWrapDtoTemp.searchTime;
    fBallListUpWrapDto.balls.addAll(fBallListUpWrapDtoTemp.balls);
    if(fBallListUpWrapDto.balls.length == 0){
      hasBall = false;
    }else {
      hasBall = true;
    }
    notifyListeners();
  }

  Future getTagRanking(Position currentPosition) async {
    rankingWrapDto = await _tagRepository.getTagRanking(
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
      pageCount++;
      if (pageCount * ballPageLimitSize >
          fBallListUpWrapDto.balls.length) {
        return;
      } else {
        var currentPosition =
            await _geolocationRepository.getCurrentPhoneLocation();
        getBallListUp(currentPosition, pageCount, ballPageLimitSize);
      }
    }
  }

  getCurrentPositionFromGeoLocation() async {
    selectPosition = await _geolocationRepository.getCurrentPhoneAddress();
    notifyListeners();
    return selectPosition;
  }

  bool get inlineRanking => _inlineRanking;

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }
}
