import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallHorizontalPageList.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpFromMapArea.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class I001MainPage extends StatefulWidget {
  const I001MainPage({Key key}) : super(key: key);

  @override
  _I001MainPageState createState() => _I001MainPageState();
}

class _I001MainPageState extends State<I001MainPage>
    with WidgetsBindingObserver {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => I001MainPageViewModel(
            geoViewSearchManagerInputPort: sl(),
            mapScreenPositionUseCaseInputPort: sl(),
            ballListMediator: sl(),
            mapBallMarkerFactory: sl(),
            context: context),
        child: Consumer<I001MainPageViewModel>(
          builder: (_, model, __) {
            return Stack(
              children: [
                GoogleMap(
                  key: model.googleMapKey,
                  markers: model.ballMarker,
                  initialCameraPosition: model.googleMapCurrentPosition,
                  myLocationEnabled: true,
                  compassEnabled: false,
                  onMapCreated: model.onMapCreated,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  left: 0,
                  bottom: 16,
                  child: FullBallHorizontalPageList(
                      fullBallHorizontalPageListController:
                          model.fullBallHorizontalPageListController,
                      onSelectBall: model.onSelectBall,
                      ballListMediator: model.ballListMediator),
                )
              ],
            );
          },
        ));
  }
}

class I001MainPageViewModel extends ChangeNotifier
    implements GeoViewSearchListener, BallListMediatorComponent {
  final BuildContext context;

  final GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;

  final MapScreenPositionUseCaseInputPort mapScreenPositionUseCaseInputPort;

  final BallListMediator ballListMediator;

  final MapBallMarkerFactory mapBallMarkerFactory;

  final Set<Marker> ballMarker = Set<Marker>();

  final FullBallHorizontalPageListController
      fullBallHorizontalPageListController;

  Completer<GoogleMapController> _googleMapController = Completer();

  CameraPosition googleMapCurrentPosition;

  GlobalKey googleMapKey = GlobalKey();

  I001MainPageViewModel(
      {this.context,
      this.ballListMediator,
      this.geoViewSearchManagerInputPort,
      this.mapScreenPositionUseCaseInputPort,
      this.mapBallMarkerFactory})
      : fullBallHorizontalPageListController =
            FullBallHorizontalPageListController() {
    this.init();
  }

  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);

    geoViewSearchManagerInputPort
        .search(geoViewSearchManagerInputPort.currentSearchPosition);
  }

  init() async {
    ballListMediator.registerComponent(this);
    googleMapCurrentPosition = CameraPosition(
        target: LatLng(
            geoViewSearchManagerInputPort.currentSearchPosition.latitude,
            geoViewSearchManagerInputPort.currentSearchPosition.longitude),
        zoom: 14.4);
    geoViewSearchManagerInputPort.subscribe(this);
  }

  @override
  Future<void> search(Position loadPosition) async {
    print(loadPosition);
    ballListMediator.fBallListUpUseCaseInputPort = FBallListUpFromMapArea(
        await getAreaPoint(loadPosition),
        fBallRepository: sl());
    await ballListMediator.searchFirst();
    firstBallSelect();
  }

  void firstBallSelect() {
    if (ballListMediator.ballList.length > 0) {
      onSelectBall(ballListMediator.ballList[0]);
    }
  }

  Future<BallFromMapAreaReqDto> getAreaPoint(Position centerPosition) async {
    final GoogleMapController controller = await _googleMapController.future;
    final RenderBox mapRenderBoxRed =
        googleMapKey.currentContext.findRenderObject();

    LatLng southwestPoint =
        await mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            16,
            MediaQuery.of(context).size.height - 180);
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
    ballMarker.clear();
    ballMarker.addAll(_makeMaker(fBallResDto));
    notifyListeners();
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    geoViewSearchManagerInputPort.unSubscribe(this);
    super.dispose();
  }

  void refreshMapKey() {
    googleMapKey = GlobalKey();
  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }

  Set<Marker> _makeMaker(FBallResDto selectBall) {
    Set<Marker> ballMarker = Set<Marker>();
    ballListMediator.ballList.forEach((element) {
      ballMarker.add(mapBallMarkerFactory.getBallMaker(
          element.ballType,
          element.ballUuid,
          Position(latitude: element.latitude, longitude: element.longitude),
          select: selectBall.ballUuid == element.ballUuid,
          ballMarkerSize: BallMarkerSize.Small,
          onTap: (){
            fullBallHorizontalPageListController.moveToBall(element);
          }
      ));
    });
    return ballMarker;
  }
}
