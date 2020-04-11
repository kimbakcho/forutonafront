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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier {
  H001PageState currentState;
  String selectPositionAddress = "로 딩 중";
  Position currentPosition;
  bool rankingAutoPlay = false;
  bool hasBall = true;
  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();
  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;
  TagRankingWrapDto rankingWrapDto;
  FBallListUpWrapDto fBallListUpWrapDto =
      new FBallListUpWrapDto(DateTime.now(), []);

  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  TagRepository _tagRepository = new TagRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();
  FBallRepository _fBallRepository = new FBallRepository();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  H001ViewModel() {
    currentState = H001PageState.H001_01;
    rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    init();
  }

  init() async {
    currentPosition = await Geolocator().getCurrentPosition();
    await reFreshSearchBall(currentPosition);
  }

  Future reFreshSearchBall(Position serachPosition) async {
    selectPositionAddress = "로 딩 중";
    selectPositionAddress = await geAddressFromGeoLocation(serachPosition);
    getTagRanking(serachPosition);
    fBallListUpWrapDto = new FBallListUpWrapDto(DateTime.now(), []);
    getBallListUp(serachPosition, _pageCount, _ballPageLimitSize);
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
    fBallListUpWrapDto.searchTime = fBallListUpWrapDtoTemp.searchTime;
    fBallListUpWrapDto.balls.addAll(fBallListUpWrapDtoTemp.balls);
    if (fBallListUpWrapDto.balls.length == 0) {
      hasBall = false;
    } else {
      hasBall = true;
    }
    notifyListeners();
  }

  Future getTagRanking(Position currentPosition) async {
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

    /**
     * 맨 밑으로 왔을때 무한 스크롤을 위한 이벤트 처리
     */
    if (h001CenterListViewController.offset >=
            h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange) {
      _pageCount++;
      if (_pageCount * _ballPageLimitSize > fBallListUpWrapDto.balls.length) {
        return;
      } else {
        getBallListUp(currentPosition, _pageCount, _ballPageLimitSize);
      }
    }
  }

  Future<String> geAddressFromGeoLocation(Position reqPosition) async {
    var address = await _geolocationRepository.getPositionAddress(reqPosition);
    notifyListeners();
    return address;
  }

  bool get inlineRanking => _inlineRanking;

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  ///H007의 하단 검색 버튼에서로부터의 검색 실행
  onFromH007Serach(LatLng searchPosition) async{
    Position position = new Position(
      longitude: searchPosition.longitude,
      latitude: searchPosition.latitude
    );
    await reFreshSearchBall(position);
  }
}
