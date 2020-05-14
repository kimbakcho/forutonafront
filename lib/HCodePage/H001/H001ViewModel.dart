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
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:geolocator/geolocator.dart';


enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier {
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
  FBallListUpWrapDto fBallListUpWrapDto =
      new FBallListUpWrapDto(DateTime.now(), []);
  bool _isLoading = false;


  Position _currentPosition;
  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  TagRepository _tagRepository = new TagRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();
  FBallRepository _fBallRepository = new FBallRepository();


  H001ViewModel(this._context) {
    init();
  }

  init() async {
    currentState = H001PageState.H001_01;
    rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    _setIsLoading(true);
    if(await geoPermissionCheck()){
      await reFreshSearchBall(_currentPosition);
    }
    _setIsLoading(false);
  }

  bool getIsLoading(){
    return _isLoading;
  }

  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }


  Future<bool> geoPermissionCheck() async {
    if(await GeoLocationUtil.permissionCheck()){
      _currentPosition = await Geolocator().getCurrentPosition();
      return true;
    }else {
      return false;
    }

  }

  moveToH007() async {
    ///Navigator 는 검색 위치로 지정한 LatLng 이 나온다.
    MapSearchGeoDto position = await Navigator.of(_context).push(MaterialPageRoute(
        settings: RouteSettings(name: "H007"),
        builder: (context)=> H007MainPage(_currentPosition,
            selectPositionAddress)
    ));
    if(position != null){
      _currentPosition = Position(latitude: position.latLng.latitude,longitude: position.latLng.longitude);
      await reFreshSearchBall(_currentPosition,address: position.descriptionAddress);
    }

  }

  Future reFreshSearchBall(Position serachPosition,{String address}) async {
    if(address == null){
      selectPositionAddress = "로 딩 중";
      notifyListeners();
      selectPositionAddress = await getAddressFromGeoLocation(serachPosition);
    }else {
      selectPositionAddress = address;
    }
    getTagRanking(serachPosition);
    fBallListUpWrapDto = new FBallListUpWrapDto(DateTime.now(), []);
    _pageCount = 0;
    getBallListUp(serachPosition, _pageCount, _ballPageLimitSize);
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
    if(page == 0){
      fBallListUpWrapDto.balls.clear();
      notifyListeners();
    }
    fBallListUpWrapDto.searchTime = fBallListUpWrapDtoTemp.searchTime;
    fBallListUpWrapDto.balls.addAll(fBallListUpWrapDtoTemp.balls);

    if (fBallListUpWrapDto.balls.length == 0) {
      hasBall = false;
      addressDisplayShowFlag = true;
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

    if (_isScrollerBottomOver()) {
      _pageCount++;
      if (!_hasBalls()) {
        return;
      } else {
        getBallListUp(_currentPosition, _pageCount, _ballPageLimitSize);
      }
    }
  }

  bool _hasBalls() {
    return !(_pageCount * _ballPageLimitSize > fBallListUpWrapDto.balls.length);
  }

  bool _isScrollerBottomOver() {
    return h001CenterListViewController.offset >=
          h001CenterListViewController.position.maxScrollExtent &&
      !h001CenterListViewController.position.outOfRange;
  }

  Future<String> getAddressFromGeoLocation(Position reqPosition) async {
    var address = await _geolocationRepository.getPositionAddress(reqPosition);
    notifyListeners();
    return address;
  }


  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  isFoldTagRanking(){
    return _inlineRanking;
  }


  void goBallMakePage() async {
     var currentUser = await FirebaseAuth.instance.currentUser();
     if(currentUser != null){
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
       reFreshSearchBall(_currentPosition);
     }else {
       Navigator.push(
           _context,
           MaterialPageRoute(
               settings: RouteSettings(name: "/J001"),
               builder: (context) {
                 return J001View();
               }));
     }


  }
}
