import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagUseCaseIp.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagUseCaseOp.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';
import 'package:geolocator/geolocator.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier implements  FBallListUpUseCaseOutputPort,TagUseCaseOp{
  final BuildContext _context;
  String selectPositionAddress = "로 딩 중";
  bool rankingAutoPlay = false;
  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();
  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;
  FBallListUpUseCaseInputPort _fBallListUpUseCaseIp;
  List<BallStyle1Widget> ballWidgetLists = [];
  Position _currentSearchPosition;
  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;

  TagUseCaseIp _tagUseCaseIp = TagUseCase();



      bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//  TagRankingWrapDto rankingWrapDto;
  List<TagRankingDto> tagRankingDtos;

  H001ViewModel(this._context) {
    init();
  }

  init() async {
    _fBallListUpUseCaseIp = FBallListUpUseCase(
      fBallRepository: FBallRepositoryImpl(fBallRemoteDataSource: FBallRemoteSourceImpl()),
      geoLocationUtil: GeoLocationUtilUseCase(),
      fBallListUpUseCaseOutputPort: this,
    );

    setAddressText("로딩중");
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    _currentSearchPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    searchFBallPosition(searchPosition: _currentSearchPosition,findAddress: true);
    getTagRanking(_currentSearchPosition);
  }

  Future searchFBallPosition({@required Position searchPosition,int pageCount = 0,bool findAddress = true}) async {
    isLoading = true;
    await GeoLocationUtilUseCase().useGpsReq(_context);
    FBallListUpReqDto ballListUpReqDto = new FBallListUpReqDto(
        latitude: searchPosition.latitude,
        longitude: searchPosition.longitude,
        ballLimit: 1000,
        page: pageCount,
        size: _ballPageLimitSize,
        sort: "Influence,DESC",
        findAddress: findAddress);
    await _fBallListUpUseCaseIp.positionSearchListUpBall(searchReqDto: ballListUpReqDto);
    isLoading= false;
  }

  @override
  onPositionSearchListUpBall({@required List<FBallResDto> fBallResDtos,@required String address}) async {
    if(isFirstPage){
      this.ballWidgetLists.clear();
    }
    this.ballWidgetLists.addAll(fBallResDtos
        .map((x) => BallStyle1Widget.create(fBallResDto: x,))
        .toList());
    if(address != null){
      setAddressText(address);
    }
    _showAddressDisplay();
    notifyListeners();
  }

  bool _showAddressDisplay() => addressDisplayShowFlag = true;

  bool isBallEmpty() => this.ballWidgetLists.length == 0;

  _addPageCount(){
    this._pageCount++;
  }

  get isFirstPage{
    if(this._pageCount == 0){
      return true;
    }else {
      return false;
    }
  }

  void setAddressText(String s) {
    this.selectPositionAddress = s;
    notifyListeners();
  }

  moveToH007() async {
    MapSearchGeoDto position = await Navigator.of(_context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "H007"),
            builder: (context) =>
                H007MainPage(_currentSearchPosition, selectPositionAddress)));
    if (position != null) {
      isLoading = true;
      _currentSearchPosition = Position(
          latitude: position.latLng.latitude,
          longitude: position.latLng.longitude);

      await searchFBallPosition(searchPosition: _currentSearchPosition,findAddress: false);

      setAddressText(position.descriptionAddress);

      isLoading = false;
    }
    notifyListeners();
  }
  h001CenterListViewControllerListener() async {
    if (_isUserScrollerForward()) {
      _onUserScrollerForward();
    }
    if(_isUserScrollerReverse()) {
      _onUserScrollerReverse();
    }

    if (_isScrollerBottomOver()) {
      _onScrollerOver();
    }
    if(_isScrollerTopOver()){
      _onScrollerTopOver();
    }
  }

  int setFirstPage() => _pageCount = 0;

  void _onScrollerOver() async {
    _addPageCount();
    if(_hasMoreListUpBalls()) {
      _addPageCount();
      await searchFBallPosition(searchPosition: _currentSearchPosition,pageCount: _pageCount,findAddress: false);
      moveScrollerDown();
    }
  }

  void _onScrollerTopOver() async {
    setFirstPage();
    await searchFBallPosition(searchPosition: _currentSearchPosition,pageCount: _pageCount,findAddress: false);
  }


  Future<void> moveScrollerDown() {
    return h001CenterListViewController.animateTo(h001CenterListViewController.offset+(MediaQuery.of(_context).size.height/2),
        duration: Duration(milliseconds: 300), curve: Curves.linear );
  }


  void _onUserScrollerReverse() {
    _hideAddressWithMakeBtn();
    notifyListeners();
  }

  void _onUserScrollerForward() {
    _showAddressWithMakeBtn();
    notifyListeners();
  }

  bool _isUserScrollerReverse() {
    return h001CenterListViewController.position.userScrollDirection ==
      ScrollDirection.reverse;
  }

  void _hideAddressWithMakeBtn() {
    _hideAddressDisplay();
    _hideMakeButtonDisplay();
  }

  void _showAddressWithMakeBtn() {
    _showAddressDisplay();
    _showMakeButtonDisplay();
  }

  bool _hideMakeButtonDisplay() => makeButtonDisplayShowFlag = false;

  void _hideAddressDisplay() {
    addressDisplayShowFlag = false;
  }

  bool _showMakeButtonDisplay() => makeButtonDisplayShowFlag = true;

  bool _isUserScrollerForward() {
    return h001CenterListViewController.position.userScrollDirection ==
      ScrollDirection.forward;
  }

  bool _hasMoreListUpBalls() {
    return !(_pageCount * _ballPageLimitSize >
        this.ballWidgetLists.length);
  }
  bool _isScrollerTopOver(){
    return h001CenterListViewController.offset <= h001CenterListViewController.position.minScrollExtent-100;
  }
  bool _isScrollerBottomOver() {
    return h001CenterListViewController.offset >=
        h001CenterListViewController.position.maxScrollExtent &&
        !h001CenterListViewController.position.outOfRange;
  }

  void goBallMakePage() async {
    if (await isLogin()) {
      await Navigator.push(
          _context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/H002"),
              builder: (context) {
                return H002Page(
                  heroTag: "H001MakeButton",
                );
              }));
      _currentSearchPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
      setFirstPage();
      await searchFBallPosition(searchPosition: _currentSearchPosition,findAddress: false);

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

  Future<bool> isLogin() async => await FirebaseAuth.instance.currentUser()!=null;


  //------------------Clean arch-------------------------------

  Future getTagRanking(Position currentPosition) async {
    _tagUseCaseIp.getTagRanking(reqDto: TagRankingReqDto(currentPosition.latitude, currentPosition.longitude, 10), op: this);
  }

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  isFoldTagRanking() {
    return _inlineRanking;
  }

  void gotoTagSearch(String tagName) {
    Navigator.of(_context).push(
      MaterialPageRoute(
        builder: (_) => H005MainPage(tagName,initPageState: H005PageState.Tag)
      )
    );
  }

  String changeTagValueDisplay(double value){
    return NomalValueDisplay.changeIntDisplaystr(value);
  }

  @override
  void onTagRanking(List<TagRankingDto> tagRankingDtos) {
    this.tagRankingDtos = tagRankingDtos;
    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

}
