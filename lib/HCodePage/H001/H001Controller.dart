import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/H002/H002Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class H001Controller {
  H001ViewModel h001viewModel;
  Position _currentSearchPosition;
  String _currentSearchAddress;

  FBallListUpFromInfluencePowerUseCaseInputPort _fBallListUpFromInfluencePowerUseCaseInputPort;
  TagRankingFromBallInfluencePowerUseCaseInputPort _tagRankingFromPositionUseCaseInputPort;
  AuthUserCaseInputPort _authUserCaseInputPort;

  BuildContext context;

  bool _subScrollerTopOver = false;

  H001Controller({@required this.context,@required this.h001viewModel}){
    _fBallListUpFromInfluencePowerUseCaseInputPort =
        FBallListUpFromInfluencePowerUseCase(
            fBallRepository: FBallRepositoryImpl(
                fBallRemoteDataSource: FBallRemoteSourceImpl()),
            fBallListUpUseCaseOutputPort: h001viewModel);

    _tagRankingFromPositionUseCaseInputPort = TagRankingFromBallInfluencePowerUseCase(
      tagRepository: TagRepositoryImpl(fBallTagRemoteDataSource: FBallTagRemoteDataSourceImpl()),
      outputPort: h001viewModel
    );
    _authUserCaseInputPort = FireBaseAuthUseCase();

    init();
  }
  init() async {
    h001viewModel.h001CenterListViewController
        .addListener(h001CenterListViewControllerListener);

    h001viewModel.onAddressText("로딩중");

    await GeoLocationUtilUseCase().useGpsReq(context);

    _currentSearchPosition =
        await GeoLocationUtilUseCase().getCurrentWithLastPosition();

    _currentSearchAddress = await getCurrentSearchPositionAddress();

    h001viewModel.onAddressText(_currentSearchAddress);

    h001viewModel.onShowAddressDisplay();

    _searchFBallFromBallInfluencePowerWithCurrentSearchPosition();

    _searchTagRankingFromBallInfluencePowerWithCurrentSearchPosition();
  }

  Future<void> _searchTagRankingFromBallInfluencePowerWithCurrentSearchPosition() async {
    await _tagRankingFromPositionUseCaseInputPort.reqTagRankingFromBallInfluencePower(
        reqDto: TagRankingFromBallInfluencePowerReqDto(position: _currentSearchPosition,limit: 10));
  }

  Future<String> getCurrentSearchPositionAddress() async {
    return await GeoLocationUtilUseCase().getPositionAddress(Position(
      latitude: _currentSearchPosition.latitude,
      longitude: _currentSearchPosition.longitude));
  }

  Future _searchFBallFromBallInfluencePowerWithCurrentSearchPosition(
      ) async {
    h001viewModel.onShowLoading();
    await _fBallListUpFromInfluencePowerUseCaseInputPort
        .reqBallListUpFromInfluencePower(searchReqDto: _currentSearchPosition);
    h001viewModel.onHideLoading();
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
    if (h001viewModel.h001CenterListViewController.offset <=
        h001viewModel.h001CenterListViewController.position.minScrollExtent - 100) {
      _subScrollerTopOver = true;
    }
    if (_subScrollerTopOver &&
        !h001viewModel.h001CenterListViewController.position.outOfRange) {
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
    _fBallListUpFromInfluencePowerUseCaseInputPort.pageReset();
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

      h001viewModel.onShowAddressDisplay();

      h001viewModel.onAddressText(position.descriptionAddress);
    }
  }

  bool isNoneSelectPosition(MapSearchGeoDto position) => position != null;

  Future<MapSearchGeoDto> gotoH007Page() async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
          settings: RouteSettings(name: "H007"),
          builder: (context) =>
              H007MainPage(_currentSearchPosition, _currentSearchAddress)));
  }

  bool _isScrollerBottomOver() {
    return h001viewModel.h001CenterListViewController.offset >=
        h001viewModel.h001CenterListViewController.position.maxScrollExtent &&
        !h001viewModel.h001CenterListViewController.position.outOfRange;
  }
  void _scrollerOver() async {
    if (_fBallListUpFromInfluencePowerUseCaseInputPort.hasMoreListUpBall(nowBallCount: h001viewModel.currentBallWidgetCount)) {
      _fBallListUpFromInfluencePowerUseCaseInputPort.nextPage();
      await _searchFBallFromBallInfluencePowerWithCurrentSearchPosition();
      h001viewModel.onMoveScrollerDown();
    }
  }

  bool _isUserScrollerForward() {
    return h001viewModel.h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.forward;
  }

  bool _isUserScrollerReverse() {
    return h001viewModel.h001CenterListViewController.position.userScrollDirection ==
        ScrollDirection.reverse;
  }

  void _showAddressWithMakeBtn() {
    h001viewModel.onShowAddressDisplay();
    h001viewModel.onShowMakeButtonDisplay();
  }

  void _hideAddressWithMakeBtn() {
    h001viewModel.onHiedAddressDisplay();
    h001viewModel.onHiedMakeButtonDisplay();
  }

  void goBallMakePage() async {
    if (await _authUserCaseInputPort.checkLogin()) {
      await gotoH002Page();
      _currentSearchPosition = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
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

  void showUnInlineRankingWidget() {
    h001viewModel.onShowUnInlineRankingWidget();
  }

  void showInlineRankingWidget() {
    h001viewModel.onShowInlineRankingWidget();
  }

}