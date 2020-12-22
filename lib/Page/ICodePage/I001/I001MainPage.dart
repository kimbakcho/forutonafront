import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallHorizontalPageList.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendAniContent.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpFromMapArea.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/ICodePage/I001/BallListRefreshBtn.dart';
import 'package:forutonafront/Page/ICodePage/I001/MyLocationBtn.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class I001MainPage extends StatefulWidget {
  final GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;
  final TopH_I_001NavExpendAniContentController
      topH_I_001NavExpendAniContentController;

  const I001MainPage(
      {Key key,
      this.geoViewSearchManagerInputPort,
      this.topH_I_001NavExpendAniContentController})
      : super(key: key);

  @override
  _I001MainPageState createState() => _I001MainPageState();
}

class _I001MainPageState extends State<I001MainPage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<I001MainPage> {
  _I001MainPageState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var model = Provider.of<I001MainPageViewModel>(context);
    model.refreshMapKey();
    setState(() {});
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => I001MainPageViewModel(
            geoViewSearchManagerInputPort: widget.geoViewSearchManagerInputPort,
            mapScreenPositionUseCaseInputPort: sl(),
            ballListMediator: BallListMediatorImpl(),
            mapBallMarkerFactory: sl(),
            geolocatorAdapter: sl(),
            geoLocationUtilForeGroundUseCaseInputPort: sl(),
            topH_I_001NavExpendAniContentController: widget.topH_I_001NavExpendAniContentController,
            fluttertoastAdapter: sl(),
            context: context),
        child: Consumer<I001MainPageViewModel>(builder: (_, model, __) {
          return Stack(children: [
            GoogleMap(
              key: model._googleMapKey,
              markers: model._ballMarker,
              initialCameraPosition: model._googleMapCurrentPosition,
              myLocationEnabled: true,
              compassEnabled: false,
              onCameraIdle: model._onCameraIdle,
              onCameraMove: model.onCameraMove,
              onMapCreated: model.onMapCreated,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
            Positioned(
              left: 0,
              bottom: 16,
              child: FullBallHorizontalPageList(
                  fullBallHorizontalPageListController:
                      model._fullBallHorizontalPageListController,
                  onSelectBall: model.onSelectBall,
                  ballListMediator: model.ballListMediator),
            ),
            model._showRefreshBtn
                ? Positioned(
                    top: 16,
                    left: 16,
                    child: BallListRefreshBtn(
                      onRefresh: model._onRefresh,
                    ),
                  )
                : Container(),
            model._showMyLocationBtn
                ? Positioned(
                    top: 16,
                    right: 16,
                    child: MyLocationBtn(
                      onMovetoMyLocation: model._onMovetoMyLocation,
                    ),
                  )
                : Container(),
            model._isLoading ? CommonLoadingComponent() : Container(),
          ]);
        }));
  }

  @override
  bool get wantKeepAlive => true;
}

class I001MainPageViewModel extends ChangeNotifier
    implements GeoViewSearchListener, SearchCollectMediatorComponent {
  final BuildContext context;

  final GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;

  final MapScreenPositionUseCaseInputPort mapScreenPositionUseCaseInputPort;

  final BallListMediator ballListMediator;

  final MapBallMarkerFactory mapBallMarkerFactory;

  final Set<Marker> _ballMarker = Set<Marker>();

  final FullBallHorizontalPageListController
      _fullBallHorizontalPageListController;

  final FluttertoastAdapter fluttertoastAdapter;

  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;

  final GeolocatorAdapter geolocatorAdapter;

  Completer<GoogleMapController> _googleMapController = Completer();

  CameraPosition _googleMapCurrentPosition;

  GlobalKey _googleMapKey = GlobalKey();

  bool _showRefreshBtn = false;

  bool _showMyLocationBtn = false;

  int _idleCount = 0;

  Queue<Position> searchQueue = Queue<Position>();

  final TopH_I_001NavExpendAniContentController
      topH_I_001NavExpendAniContentController;

  I001MainPageViewModel(
      {this.context,
      this.ballListMediator,
      this.geolocatorAdapter,
      this.geoViewSearchManagerInputPort,
      this.mapScreenPositionUseCaseInputPort,
      this.fluttertoastAdapter,
      this.geoLocationUtilForeGroundUseCaseInputPort,
      this.topH_I_001NavExpendAniContentController,
      this.mapBallMarkerFactory})
      : _fullBallHorizontalPageListController =
            FullBallHorizontalPageListController() {
    this.init();
  }

  _onMovetoMyLocation() async {
    await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();

    final GoogleMapController controller = await _googleMapController.future;

    var position = await geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPosition();

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14.4746)));

    notifyListeners();
  }

  _onRefresh() {
    var target = _googleMapCurrentPosition.target;
    topH_I_001NavExpendAniContentController.loadPosition(
        Position(latitude: target.latitude, longitude: target.longitude));
    notifyListeners();

  }

  _onCameraIdle() async {
    //좌표를 얻기 위해 지도를 그리는 1초 기다림
    //
    // await Future.delayed(Duration(seconds: 1));

    Future.delayed(Duration(seconds: 1),()async{
      await viewButtonControl();

      await searchLoadQueue();

      notifyListeners();
    });


  }

  Future searchLoadQueue() async {
    while (searchQueue.isNotEmpty) {
      ballListMediator.fBallListUpUseCaseInputPort = FBallListUpFromMapArea(
          await getAreaPoint(searchQueue.removeLast()),
          fBallRepository: sl());
      await ballListMediator.searchFirst();
      _ballMarker.clear();
      firstBallSelect();
      _showRefreshBtn = false;
      notifyListeners();
    }
  }

  Future viewButtonControl() async {
    if (_idleCount > 0) {
      _showRefreshBtn = true;
      var position = geoLocationUtilForeGroundUseCaseInputPort
          .getCurrentWithLastPositionInMemory();
      var distanceBetween = await geolocatorAdapter.distanceBetween(
          position.latitude,
          position.longitude,
          _googleMapCurrentPosition.target.latitude,
          _googleMapCurrentPosition.target.longitude);
      if (distanceBetween < 10) {
        _showMyLocationBtn = false;
      } else {
        _showMyLocationBtn = true;
      }
    }
    _idleCount++;
  }

  onCameraMove(CameraPosition cameraPosition) async {
    _googleMapCurrentPosition = cameraPosition;
  }

  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);

    geoViewSearchManagerInputPort.search(
        geoViewSearchManagerInputPort.currentSearchPosition, 14.46);
  }

  init() async {
    ballListMediator.registerComponent(this);
    _googleMapCurrentPosition = CameraPosition(
        target: LatLng(
            geoViewSearchManagerInputPort.currentSearchPosition.latitude,
            geoViewSearchManagerInputPort.currentSearchPosition.longitude),
        zoom: 14.4);
    geoViewSearchManagerInputPort.subscribe(this);
  }

  @override
  Future<void> search(Position loadPosition, double zoomLevel) async {
    searchQueue.addFirst(loadPosition);

    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loadPosition.latitude, loadPosition.longitude),
        zoom: zoomLevel)));
  }

  void firstBallSelect() {
    if (ballListMediator.itemList.length > 0) {
      onSelectBall(ballListMediator.itemList[0]);
    }
  }

  Future<BallFromMapAreaReqDto> getAreaPoint(Position centerPosition) async {
    final GoogleMapController controller = await _googleMapController.future;

    final RenderBox mapRenderBoxRed =
        _googleMapKey.currentContext.findRenderObject();

    LatLng southwestPoint =
        await mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            16,
            MediaQuery.of(context).size.height - 250);

    LatLng northeastPoint =
        await mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            MediaQuery.of(context).size.width - 16,
            108);

    return BallFromMapAreaReqDto(
        southwestPoint.latitude,
        southwestPoint.longitude,
        northeastPoint.latitude,
        northeastPoint.longitude,
        centerPosition.latitude,
        centerPosition.longitude);
  }

  onSelectBall(FBallResDto fBallResDto) {
    _ballMarker.clear();
    _ballMarker.addAll(_makeMaker(fBallResDto));
    notifyListeners();
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    geoViewSearchManagerInputPort.unSubscribe(this);
    super.dispose();
  }

  void refreshMapKey() {
    _googleMapKey = GlobalKey();
  }

  bool get _isLoading {
    return ballListMediator.isLoading;
  }

  Set<Marker> _makeMaker(FBallResDto selectBall) {
    Set<Marker> ballMarker = Set<Marker>();
    ballListMediator.itemList.forEach((element) {
      ballMarker.add(mapBallMarkerFactory.getBallMaker(
          element.ballType,
          element.ballUuid,
          Position(latitude: element.latitude, longitude: element.longitude),
          select: selectBall.ballUuid == element.ballUuid,
          ballMarkerSize: BallMarkerSize.Small, onTap: () {
        _fullBallHorizontalPageListController.moveToBall(element);
      }));
    });
    return ballMarker;
  }

  @override
  void onItemListEmpty() {
    fluttertoastAdapter.showToast(msg: "여기에는 컨텐츠가 없습니다");
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }
}

abstract class I001PageListener {
  void onLoadAddress();
}
