import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingWrapDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Data/DataStore/IFBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallrepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseIp.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseOp.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetInter.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier implements  BallStyle1WidgetInter,FBallListUpUseCaseOp{
  final BuildContext _context;
  String selectPositionAddress = "로 딩 중";
  bool rankingAutoPlay = false;
  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();
  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;
  FBallListUpUseCaseIp fBallListUpUseCaseIp;
  List<BallStyle1Widget> ballWidgetLists = [];
  Position _currentSearchPosition;
  bool _inlineRanking = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;

  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }
  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  TagRankingWrapDto rankingWrapDto;


  H001ViewModel(this._context) {
    init();
  }

  init() async {
    fBallListUpUseCaseIp = FBallListUpUseCase(
      ifBallRepository: FBallrepositoryImpl(ifBallRemoteDataSource: FBallRemoteSourceImpl()),
      geoLocationUtil: GeoLocationUtilUseCase(),
      fBallListUpUseCaseOp: this,
    );

    rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    setAddressText("로딩중");
    h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);
    _currentSearchPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    await searchFBallPosition(searchPosition: _currentSearchPosition,findAddress: true);
    getTagRanking(_currentSearchPosition);
  }

  Future searchFBallPosition({@required Position searchPosition,int pageCount = 0,bool findAddress = true}) async {
    _setIsLoading(true);
    await GeoLocationUtilUseCase().useGpsReq(_context);
    FBallListUpReqDto ballListUpReqDto = new FBallListUpReqDto(
        latitude: searchPosition.latitude,
        longitude: searchPosition.longitude,
        ballLimit: 1000,
        page: pageCount,
        size: _ballPageLimitSize,
        sort: "Influence,DESC",
        findAddress: findAddress);
    await fBallListUpUseCaseIp.positionSearchListUpBall(searchReqDto: ballListUpReqDto);
    _setIsLoading(false);
  }

  @override
  onPositionSearchListUpBall({@required List<FBallResDto> fBallResDtos,@required String address}) async {
    if(isFirstPage){
      this.ballWidgetLists.clear();
    }
    this.ballWidgetLists.addAll(fBallResDtos
        .map((x) => BallStyle1Widget.create(x.ballType,BallStyle1WidgetController(x,this)))
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
      _setIsLoading(true);
      _currentSearchPosition = Position(
          latitude: position.latLng.latitude,
          longitude: position.latLng.longitude);

      await searchFBallPosition(searchPosition: _currentSearchPosition,findAddress: false);

      setAddressText(position.descriptionAddress);

      _setIsLoading(false);
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
    TagRepository _tagRepository = new TagRepository();
    rankingWrapDto = await _tagRepository.getTagRanking(new TagRankingReqDto(
        currentPosition.latitude, currentPosition.longitude, 10));
    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  isFoldTagRanking() {
    return _inlineRanking;
  }

  @override
  onRequestReFreshBall(FBallResDto reFreshNeedBall) async {
//    _setIsLoading(true);
    var ballStyle1ReFreshBallUtil = BallStyle1ReFreshBallUtil();
    await ballStyle1ReFreshBallUtil.reFreshBallAndUiUpdate(ballWidgetLists, reFreshNeedBall, this);
    notifyListeners();
//    _setIsLoading(false);
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

}
