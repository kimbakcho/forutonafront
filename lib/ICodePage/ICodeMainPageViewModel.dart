import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeoLocationUtil.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/FBallResForMarkerDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/MakerSupportStyle1.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetInter.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/MapGeoPage/MapGeoSearchPage.dart';
import 'package:forutonafront/MapGeoPage/MapSearchGeoDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ICodeMainPageViewModel extends ChangeNotifier
    implements BallStyle3WidgetInter {
  final BuildContext _context;
  bool _flagIdleIgore = true;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  FBallListUpWrapDto _fBallListUpWrapDto;
  bool _moveFromMapBallSelect = false;
  CameraPosition _currentMapPosition;
  CodeMainViewModel _codeMainViewModel;
  FBallRepository _fBallRepository = new FBallRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();

  CameraPosition initCameraPosition;
  String currentAddress = "";
  final Set<Marker> markers = {};
  GlobalKey mapContainerGlobalKey = GlobalKey();
  List<FBallResForMarker> listUpBalls = [];
  bool reFreshBtnActive = false;

  PageController bottomPageController =
      new PageController(initialPage: 0, keepPage: true, viewportFraction: 0.9);

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Completer<GoogleMapController> _googleMapController = Completer();

  ICodeMainPageViewModel(this._context) {
    _codeMainViewModel = Provider.of<CodeMainViewModel>(_context);
    if (_codeMainViewModel != null &&
        _codeMainViewModel.lastKnownPosition != null) {
      _codeMainViewModel = Provider.of<CodeMainViewModel>(_context);
      initCameraPosition = CameraPosition(
          target: LatLng(_codeMainViewModel.lastKnownPosition.latitude,
              _codeMainViewModel.lastKnownPosition.longitude),
          zoom: 14.4746);
      currentAddress = _codeMainViewModel.firstAddress;
    } else {
      initCameraPosition =
          CameraPosition(target: Preference.initPosition, zoom: 14.4746);

      currentAddress = "남산 공원";
    }
    _currentMapPosition = initCameraPosition;
    bottomPageController.addListener(onPageContollerListner);
  }

  ///Return 으로는 MapSearchGeoDto 받는다.
  onPlaceSearchTap() async {
    MapSearchGeoDto mapSearchGeoDto = await Navigator.of(_context).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "MapGeoSearchPage"),
            builder: (_) => MapGeoSearchPage(
                currentAddress,
                Position(
                    latitude: _currentMapPosition.target.latitude,
                    longitude: _currentMapPosition.target.longitude))));
    final GoogleMapController controller = await _googleMapController.future;
    _flagIdleIgore = true;
    currentAddress = mapSearchGeoDto.descriptionAddress;
    await controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: mapSearchGeoDto.latLng, zoom: 14)));
    await onRefreshBall();
    _flagIdleIgore = false;
    notifyListeners();
  }

  onBallListSelectChanged(int index) async {
    //Map에서 클릭해서 옮기는 동안에는 해당 메소드 실행을 하지 않는다. 무한 루프 방지
    if (!_moveFromMapBallSelect) {
      final GoogleMapController controller = await _googleMapController.future;
      clearBallSelect();
      listUpBalls[index].isSelectBall = true;
      drawBall(this.listUpBalls);
      notifyListeners();
      var zoomLevel = await controller.getZoomLevel();
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(listUpBalls[index].latitude, listUpBalls[index].longitude),
          zoom: zoomLevel)));
    }
  }

  clearBallSelect() {
    for (var o in listUpBalls) {
      o.isSelectBall = false;
    }
  }

  onPageContollerListner() {
    if (bottomPageController.offset >=
            bottomPageController.position.maxScrollExtent &&
        !bottomPageController.position.outOfRange) {
      _pageCount++;
      if (_pageCount * _ballPageLimitSize > _fBallListUpWrapDto.balls.length) {
        return;
      } else {
        getBallListUp();
      }
    }
  }

  onMoveStartMap() {
    reFreshBtnActive = true;
    notifyListeners();
  }

  onMoveMap(CameraPosition value) {
    _currentMapPosition = value;
  }

  onMapIdle() async {
    if (!_flagIdleIgore) {
      currentAddress = await _geolocationRepository.getPositionAddress(Position(
          latitude: _currentMapPosition.target.latitude,
          longitude: _currentMapPosition.target.longitude));
      notifyListeners();
    }
  }

  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;

    await GeoLocationUtil().useGpsReq(_context);
    var currentLocation = await GeoLocationUtil().getCurrentWithLastPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.4746)));
  }

  onCreateMap(GoogleMapController controller) async {
    _flagIdleIgore = true;
    _googleMapController.complete(controller);
    reFreshBtnActive = false;
    if (_codeMainViewModel != null &&
        _codeMainViewModel.lastKnownPosition != null) {
      await controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_codeMainViewModel.lastKnownPosition.latitude,
              _codeMainViewModel.lastKnownPosition.longitude),
          zoom: 14.4746)));
      await onRefreshBall();
      _flagIdleIgore = false;
    } else {
//      var position = await Geolocator().getLastKnownPosition();
      var positionAddress =
          await _geolocationRepository.getPositionAddress(Position(longitude: _currentMapPosition.target.longitude,latitude: _currentMapPosition.target.latitude));
      currentAddress = positionAddress;
      await controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_currentMapPosition.target.latitude, _currentMapPosition.target.longitude),
          zoom: 14.4746)));
      await onRefreshBall();
      _flagIdleIgore = false;
    }
  }

  onRefreshBall() async {
    _pageCount = 0;
    reFreshBtnActive = false;
    await getBallListUp();
  }

  Future getBallListUp() async {
    _setIsLoading(true);
    final GoogleMapController controller = await _googleMapController.future;
    final RenderBox mapRenderBoxRed =
        mapContainerGlobalKey.currentContext.findRenderObject();
//    _currentMapPosition = initCameraPosition;
    var southwestPoint = await getWidgetOffsetPositionToLatLngFromMap(
        mapRenderBoxRed, controller, 16, MediaQuery.of(_context).size.height-180);
    var northeastPoint = await getWidgetOffsetPositionToLatLngFromMap(
        mapRenderBoxRed, controller, MediaQuery.of(_context).size.width-16, 108);
    List<MultiSort> sortList = [];
    sortList.add(MultiSort("ballPower", QueryOrders.DESC));
    MultiSorts sorts = MultiSorts(sortList);
    await onSearch(
        southwestPoint, northeastPoint, sorts, _ballPageLimitSize, _pageCount);
    _setIsLoading(false);
  }

  Future<void> onSearch(LatLng southwestPoint, LatLng northeastPoint, MultiSorts sorts,
      int pageSize, int pageCount) async {
    final GoogleMapController controller = await _googleMapController.future;
    BallFromMapAreaReqDto reqDto = BallFromMapAreaReqDto(
        southwestPoint.latitude,
        southwestPoint.longitude,
        northeastPoint.latitude,
        northeastPoint.longitude,
        _currentMapPosition.target.latitude,
        _currentMapPosition.target.longitude,
        pageCount,
        pageSize,
        sorts.toQureyJson());
    _fBallListUpWrapDto = await _fBallRepository.listUpBallFromMapArea(reqDto);

    if (pageCount == 0) {
      this.listUpBalls.clear();
    }

    this.listUpBalls.addAll(_fBallListUpWrapDto.balls
        .map((x) => new FBallResForMarker(
            false, ballSelectFunction, x, BallStyle3WidgetController(x, this)))
        .toList());

    if (pageCount == 0) {
      if (this.listUpBalls.length > 0) {
        this.listUpBalls[0].isSelectBall = true;
      }
    }

    notifyListeners();
    await drawBall(this.listUpBalls);
    this.markers.add(Marker(markerId: MarkerId("southwestPoint"),position: southwestPoint));
    this.markers.add(Marker(markerId: MarkerId("northeastPoint"),position: northeastPoint));

  }

  //Ball이 화면에서 선택 될때 콜백 되는 함수
  ballSelectFunction(FBallResForMarker resDto) async {
    clearBallSelect();
    int ballIndex =
        this.listUpBalls.indexWhere((a) => (a.ballUuid == resDto.ballUuid));
    listUpBalls[ballIndex].isSelectBall = true;
    drawBall(listUpBalls);
    _moveFromMapBallSelect = true;
    await bottomPageController.animateToPage(ballIndex,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
    _moveFromMapBallSelect = false;
  }

  //마커를 그리는 메소드
  //ICodeMain은 MarkerStyle1Util 에서 선택한 Widget을 화면에 그린다.
  drawBall(List<FBallResForMarker> listUpBalls) async {
    final GoogleMapController controller = await _googleMapController.future;
    Completer<Set<Marker>> _markerCompleter = Completer();
    MakerSupportStyle1(listUpBalls, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    notifyListeners();
  }

  /**
   * Latlng 을 구글 Map Widget의 Offset 으로 변경함
   */
  Future<Point> getScreenPointFromMapLatlng(
      RenderBox mapRenderBoxRed,
      GoogleMapController controller,
      LatLng latLng,
      double widgetWidth,
      double widgetHeight) async {
    ScreenCoordinate screenCoordinate = await controller
        .getScreenCoordinate(LatLng(latLng.latitude, latLng.longitude));
    //지도를 그리는 Box Size
    Size size = mapRenderBoxRed.size;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate southwestPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.southwest.latitude,
            visibleRegion.southwest.longitude));

    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate northeastPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.northeast.latitude,
            visibleRegion.northeast.longitude));

    //위젯의 스케일 받기
    var yScale = southwestPoint.y / mapRenderBoxRed.size.height;
    var xScale = northeastPoint.x / mapRenderBoxRed.size.width;
    double offsetX = screenCoordinate.x / xScale;
    offsetX -= (widgetWidth / 2);
    double offsetY = screenCoordinate.y / yScale;
    offsetY -= (widgetHeight / 2);
    return Point(offsetX, offsetY);
  }

  Future<LatLng> getWidgetOffsetPositionToLatLngFromMap(
      RenderBox mapRenderBoxRed,
      GoogleMapController controller,
      double offsetX,
      double offsetY) async {
    //지도를 그리는 Box Size
    Size size = mapRenderBoxRed.size;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate southwestPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.southwest.latitude,
            visibleRegion.southwest.longitude));

    //현재 맵 스크린 좌표 받아옴
    ScreenCoordinate northeastPoint = await controller.getScreenCoordinate(
        LatLng(visibleRegion.northeast.latitude,
            visibleRegion.northeast.longitude));

    //위젯의 스케일 받기
    var yScale = southwestPoint.y / mapRenderBoxRed.size.height;
    var xScale = northeastPoint.x / mapRenderBoxRed.size.width;

    return await controller.getLatLng(ScreenCoordinate(
        x: (offsetX * xScale).toInt(), y: (offsetY * yScale).toInt()));
  }


  @override
  onRequestReFreshBall(FBallResDto reFreshNeedBall) async {
    _setIsLoading(true);
    var ballStyle3ReFreshBallUtil = BallStyle3ReFreshBallUtil();
    await ballStyle3ReFreshBallUtil.reFreshBallAndUiUpdate(listUpBalls, reFreshNeedBall, ballSelectFunction, this);
    drawBall(listUpBalls);
    _setIsLoading(false);
  }
}
