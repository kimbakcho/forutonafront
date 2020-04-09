import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ICodeMainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  CameraPosition initCameraPosition;
  CodeMainViewModel _codeMainViewModel;

  String currentAddress = "";
  Completer<GoogleMapController> _googleMapController = Completer();
  GeolocationRepository _geolocationRepository = GeolocationRepository();
  GlobalKey mapContainerGlobalKey = GlobalKey();
  List<FBallResDto> listUpBalls = [];
  CameraPosition _currentMapPosition;

  FBallRepository _fBallRepository = new FBallRepository();

  PageController bottomPageController =
      new PageController(initialPage: 0, keepPage: true, viewportFraction: 0.9);

  int pageCount = 0;
  int ballPageLimitSize = 20;
  FBallListUpWrapDto _fBallListUpWrapDto;

  final Set<Marker> markers = {};

  List<Widget> ballMakerWidget = [];

  ICodeMainPageViewModel(this._context) {
    _codeMainViewModel = Provider.of<CodeMainViewModel>(_context);
    initCameraPosition = CameraPosition(
        target: LatLng(_codeMainViewModel.lastKnownPosition.latitude,
            _codeMainViewModel.lastKnownPosition.longitude),
        zoom: 14.4746);
    currentAddress = _codeMainViewModel.firstAddress;
    bottomPageController.addListener(onPageContollerListner);
  }

  onPageContollerListner() {
    if (bottomPageController.offset >=
            bottomPageController.position.maxScrollExtent &&
        !bottomPageController.position.outOfRange) {
      pageCount++;
      if (pageCount * ballPageLimitSize > _fBallListUpWrapDto.balls.length) {
        return;
      } else {
        getBallListUp();
      }
    }
  }

  onMoveMap(CameraPosition value) {
    _currentMapPosition = value;
  }

  onMyLocation() async {
    final GoogleMapController controller = await _googleMapController.future;

    try {
      var currentLocation =
          await Geolocator().getCurrentPosition().timeout(Duration(seconds: 5));
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 14.4746)));
    } catch (Ex) {
      Fluttertoast.showToast(
          msg: "GPS On을 해주세요.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    onRefreshBall();
  }

  onRefreshBall() async {
    pageCount = 0;
    getBallListUp();
  }

  Future getBallListUp() async {
    final GoogleMapController controller = await _googleMapController.future;
    final RenderBox mapRenderBoxRed =
        mapContainerGlobalKey.currentContext.findRenderObject();
    _currentMapPosition = initCameraPosition;
    var southwestPoint = await getWidgetOffsetPositionToLatLngFromMap(
        mapRenderBoxRed, controller, 16.w, 465.h);
    var northeastPoint = await getWidgetOffsetPositionToLatLngFromMap(
        mapRenderBoxRed, controller, 344.w, 108.h);
    List<MultiSort> sortList = [];
    sortList.add(MultiSort("distance", QueryOrders.ASC));
    MultiSorts sorts = MultiSorts(sortList);
    if (pageCount == 0) {
      this.listUpBalls = [];
      notifyListeners();
    }
    onSearch(
        southwestPoint, northeastPoint, sorts, ballPageLimitSize, pageCount);
  }

  onSearch(LatLng southwestPoint, LatLng northeastPoint, MultiSorts sorts,
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
      this.listUpBalls = _fBallListUpWrapDto.balls;
    } else {
      this.listUpBalls.addAll(_fBallListUpWrapDto.balls);
    }
    notifyListeners();
    drawBall();
  }

  drawBall() async {
    final GoogleMapController controller = await _googleMapController.future;
//    Set<Marker> makrs = Set<Marker>();
    for (FBallResDto ball in listUpBalls) {
      this.markers.add(Marker(
          markerId: MarkerId(ball.ballUuid),
          position: LatLng(ball.latitude, ball.longitude),
          infoWindow: InfoWindow(title: ball.ballName)));

      final RenderBox mapRenderBoxRed =
          mapContainerGlobalKey.currentContext.findRenderObject();

      var screenOffset = await getScreenPointFromMapLatlng(
          mapRenderBoxRed,
          controller,
          LatLng(ball.latitude, ball.longitude),
          30.w,
          30.h);

      var widget = Positioned(
        top: screenOffset.y,
        left: screenOffset.x,
        child: IgnorePointer(
          child: Container(
              child: Container(
                  padding: EdgeInsets.only(left: 1.sp, bottom: 1.sp),
                  child: Icon(ForutonaIcon.issue,
                      size: 17.sp, color: Colors.white),
                  height: 30.00.h,
                  width: 30.00.w,
                  decoration: BoxDecoration(
                    color: Color(0xffdc3e57),
                    shape: BoxShape.circle,
                  ))),
        ),
      );
      ballMakerWidget.add(widget);
    }
//    this.mapMarks = makrs;
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
}
