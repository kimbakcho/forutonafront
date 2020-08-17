import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/FSort.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/FBallResForMarkerDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/MakerSupportStyle1.dart';
import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ICodeMainPageViewModel extends ChangeNotifier
    implements FBallListUpUseCaseOutputPort {
  final BuildContext context;
  final GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCase;
  final FBallListUpUseCaseInputPort _fBallListUpUseCaseInputPort;
  final MapScreenPositionUseCaseInputPort _mapScreenPositionUseCaseInputPort;

  bool _flagIdleIgnore = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  bool _moveFromMapBallSelect = false;
  CameraPosition currentMapPosition;

  String currentAddress = "";
  final Set<Marker> markers = {};
  GlobalKey mapContainerGlobalKey = GlobalKey();
  List<FBallResForMarker> listUpBalls = [];
  bool reFreshBtnActive = false;

  double initMapZoom = 14.4746;

  PageController bottomPageController =
      new PageController(initialPage: 0, keepPage: true, viewportFraction: 0.9);

  bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Completer<GoogleMapController> _googleMapController = Completer();

  ICodeMainPageViewModel({
    this.context,
    @required GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCase,
    @required
        FBallListUpUseCaseInputPort fBallListUpFromMapAreaUseCaseInputPort,
    @required
        MapScreenPositionUseCaseInputPort mapScreenPositionUseCaseInputPort,
  })  : _geoLocationUtilUseCase = geoLocationUtilUseCase,
        _fBallListUpUseCaseInputPort = fBallListUpFromMapAreaUseCaseInputPort,
        _mapScreenPositionUseCaseInputPort = mapScreenPositionUseCaseInputPort {
    setGoogleInitCameraPosition();
    bottomPageController.addListener(onPageControllerListener);
    currentAddress =
        _geoLocationUtilUseCase.getCurrentWithLastAddressInMemory();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white.withOpacity(0.6));
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }

  CameraPosition setGoogleInitCameraPosition() {
    return currentMapPosition = CameraPosition(
        target: LatLng(
            _geoLocationUtilUseCase
                .getCurrentWithLastPositionInMemory()
                .latitude,
            _geoLocationUtilUseCase
                .getCurrentWithLastPositionInMemory()
                .longitude),
        zoom: initMapZoom);
  }

  onPlaceSearchTap() async {
    MapSearchGeoDto mapSearchGeoDto = await Navigator.of(context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "MapGeoSearchPage"),
            builder: (_) => MapGeoSearchPage(
                currentAddress,
                Position(
                    latitude: currentMapPosition.target.latitude,
                    longitude: currentMapPosition.target.longitude))));
    final GoogleMapController controller = await _googleMapController.future;
    _flagIdleIgnore = true;
    currentAddress = mapSearchGeoDto.descriptionAddress;
    await controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: mapSearchGeoDto.latLng, zoom: 14)));
    _flagIdleIgnore = false;
    Future.delayed(Duration(seconds: 1), () async {
      await onRefreshBall();
    });

    notifyListeners();
  }

  onBallListSelectChanged(int index) async {
    //Map에서 클릭해서 옮기는 동안에는 해당 메소드 실행을 하지 않는다. 무한 루프 방지
    if (!_moveFromMapBallSelect) {
      final GoogleMapController controller = await _googleMapController.future;
      clearBallSelect();
      listUpBalls[index].isSelectBall = true;
      drawBallMarker(this.listUpBalls);
      notifyListeners();
      var zoomLevel = 14.0;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(listUpBalls[index].ballResDto.latitude,
              listUpBalls[index].ballResDto.longitude),
          zoom: zoomLevel)));
    }
  }

  clearBallSelect() {
    for (var o in listUpBalls) {
      o.isSelectBall = false;
    }
  }

  onPageControllerListener() {
    if (bottomPageController.offset >=
            bottomPageController.position.maxScrollExtent &&
        !bottomPageController.position.outOfRange) {
      _pageCount++;
      if (_pageCount * _ballPageLimitSize > listUpBalls.length) {
        return;
      } else {
        reqBallListUp();
      }
    }
  }

  onMoveStartMap() {
    reFreshBtnActive = true;
    notifyListeners();
  }

  onMoveMap(CameraPosition value) {
    currentMapPosition = value;
  }

  onMapIdle() async {
    if (!_flagIdleIgnore) {
      currentAddress = await _geoLocationUtilUseCase.getPositionAddress(
          Position(
              latitude: currentMapPosition.target.latitude,
              longitude: currentMapPosition.target.longitude));
      notifyListeners();
    }
  }

  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;

    await _geoLocationUtilUseCase.useGpsReq();
    var currentLocation =
        await _geoLocationUtilUseCase.getCurrentWithLastPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.4746)));
  }

  onCreateMap(GoogleMapController controller) async {
    _flagIdleIgnore = true;
    _googleMapController.complete(controller);
    reFreshBtnActive = false;
    await delayAndBallRefresh();
    _flagIdleIgnore = false;
  }

  Future delayAndBallRefresh() async {
    //지도의 검색 범위 측정시 너무 빨리 잡을시 검색 범위에 문제가 생김
    //해결책으로 지도가 그려줄 시간을 벌어주기 위해서 Delay
    await Future.delayed(Duration(milliseconds: 500), () async {
      await onRefreshBall();
    });
  }

  onRefreshBall() async {
    setFirstPage();
    reFreshBtnActive = false;
    await reqBallListUp();
  }

  int setFirstPage() => _pageCount = 0;

  Future reqBallListUp() async {
    isLoading = true;

    final GoogleMapController controller = await _googleMapController.future;

    final RenderBox mapRenderBoxRed =
        mapContainerGlobalKey.currentContext.findRenderObject();

    LatLng southwestPoint =
        await _mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            16,
            MediaQuery.of(context).size.height - 180);
    LatLng northeastPoint =
        await _mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            MediaQuery.of(context).size.width - 16,
            108);

    FSorts fSort = FSorts();
    fSort.sorts.add(FSort("ballPower", QueryOrders.DESC));

    await onSearch(
        southwestPoint, northeastPoint, fSort, _ballPageLimitSize, _pageCount);

    isLoading = false;
  }

  Future<void> onSearch(LatLng southwestPoint, LatLng northeastPoint,
      FSorts sorts, int pageSize, int pageCount) async {
    BallFromMapAreaReqDto reqDto = BallFromMapAreaReqDto(
        southwestPoint.latitude,
        southwestPoint.longitude,
        northeastPoint.latitude,
        northeastPoint.longitude,
        currentMapPosition.target.latitude,
        currentMapPosition.target.longitude);
//    _fBallListUpUseCaseInputPort.searchFBallListUpFromMapArea(
//        reqDto, Pageable(0, 10, ""), outputPort: this);
  }

  onBallSelectFunction(FBallResForMarker resDto) async {
    clearBallSelect();
    int ballIndex = this.listUpBalls.indexWhere(
        (a) => (a.ballResDto.ballUuid == resDto.ballResDto.ballUuid));
    listUpBalls[ballIndex].isSelectBall = true;
    drawBallMarker(listUpBalls);
    _moveFromMapBallSelect = true;
    await bottomPageController.animateToPage(ballIndex,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
    _moveFromMapBallSelect = false;
  }

  drawBallMarker(List<FBallResForMarker> listUpBalls) async {
    Completer<Set<Marker>> _markerCompleter = Completer();
    MakerSupportStyle1(listUpBalls, _markerCompleter).generate(context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    notifyListeners();
  }

  @override
  void onBallListUpFromMapArea(List<FBallResDto> resDtos, LatLng northeastLat,
      LatLng southwestLat) async {
    if (isFirstPage()) {
      this.listUpBalls.clear();
    }
    this.listUpBalls.addAll(resDtos
        .map((x) => new FBallResForMarker(
            isSelectBall: false,
            ballResDto: x,
            onTopEvent: onBallSelectFunction))
        .toList());

    if (isFirstPage()) {
      if (hasListUpBall()) {
        selectFirstBall();
      }
    }
    notifyListeners();
    await drawBallMarker(this.listUpBalls);
    this.markers.add(
        Marker(markerId: MarkerId("northeastLat"), position: northeastLat));
    print(northeastLat);
    this.markers.add(
        Marker(markerId: MarkerId("southwestLat"), position: southwestLat));
    print(southwestLat);
    notifyListeners();
  }

  void selectFirstBall() {
    this.listUpBalls[0].isSelectBall = true;
  }

  bool hasListUpBall() => this.listUpBalls.length > 0;

  bool isFirstPage() => _pageCount == 0;

  @override
  void dispose() {
    super.dispose();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }

  @override
  void searchResult(PageWrap listUpItem) {
    // TODO: implement searchResult
  }
}
