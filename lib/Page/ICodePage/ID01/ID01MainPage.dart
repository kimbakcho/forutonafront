import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidBottomSheet.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'ID01MainBottomSheet/ID01MainBottomSheetHeader.dart';
import 'ID01MainBottomSheet/ID01MainBottomSheetBody.dart';
import 'ID01MainBottomSheet/ID01MainScaffoldBottomSheet.dart';

class ID01MainPage extends StatelessWidget {
  final String ballUuid;

  final FBallResDto fBallResDto;

  const ID01MainPage({Key key, this.ballUuid, this.fBallResDto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainPageViewModel(
          context, ballUuid, fBallResDto, sl(), sl(), sl(), sl()),
      child: Consumer<ID01MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
              bottomSheet: model.isShowBottomSheet
                  ? ID01MainScaffoldBottomSheet()
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              body: model.isBallLoaded
                  ? SlidingSheet(
                      listener: model.listenerState,
                      controller: model.sheetController,
                      cornerRadius: 16,
                      isBackdropInteractable: true,
                      snapSpec: SnapSpec(
                        snap: true,
                        snappings: [
                          88,
                          model.middleSnapPosition,
                          model.topSnapPosition
                        ],
                        initialSnap: model.middleSnapPosition,
                        positioning: SnapPositioning.pixelOffset,
                        onSnap: (state, snap) {
                          print(state);
                        },
                      ),
                      body: Stack(
                        children: [
                          Container(
                            key: model.mapContainerGlobalKey,
                            child: GoogleMap(
                              initialCameraPosition:
                                  model._googleMapInitPosition,
                              markers: model.mapMarkers,
                              onMapCreated: model.onMapCreated,
                            ),
                          ),
                          Positioned(
                            height: 36,
                            width: 36,
                            top: MediaQuery.of(context).padding.top + 12,
                            left: 16,
                            child: CircleIconBtn(
                              icon: Icon(Icons.arrow_back_rounded),
                            ),
                          ),
                          Positioned(
                            height: 36,
                            width: 36,
                            top: MediaQuery.of(context).padding.top + 12,
                            right: 16,
                            child: CircleIconBtn(
                              icon: Icon(
                                ForutonaIcon.dots,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      minHeight: 100,
                      builder: (context, state) {
                        return ID01MainBottomSheetBody(
                            topPosition: model.topSnapPosition,
                            fBallResDto: fBallResDto);
                      },
                      headerBuilder: (context, state) {
                        return ID01MainBottomSheetHeader(
                            fBallResDto: fBallResDto);
                      },
                    )
                  : CommonLoadingComponent());
        },
      ),
    );
  }
}

class ID01MainPageViewModel extends ChangeNotifier {
  final String ballUuid;

  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  bool isBallLoaded = false;

  FBallResDto fBallResDto;

  CameraPosition _googleMapInitPosition;

  BuildContext _context;

  Widget _bottomWidget;

  Set<Marker> mapMarkers = new Set();

  GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCaseInputPort;

  GoogleMapController googleMapController;

  MapMakerDescriptorContainer _mapMakerDescriptorContainer;

  SheetController sheetController;

  MapScreenPositionUseCaseInputPort _mapScreenPositionUseCaseInputPort;

  GlobalKey mapContainerGlobalKey = GlobalKey();

  bool _currentCollapsed = false;

  ID01MainPageViewModel(
      this._context,
      this.ballUuid,
      this.fBallResDto,
      this._selectBallUseCaseInputPort,
      this._geoLocationUtilForeGroundUseCaseInputPort,
      this._mapMakerDescriptorContainer,
      this._mapScreenPositionUseCaseInputPort) {
    sheetController = SheetController();
    this._loadBall();
  }

  _loadBall() async {
    isBallLoaded = false;
    if (fBallResDto == null) {
      notifyListeners();
      this.fBallResDto =
          await this._selectBallUseCaseInputPort.selectBall(ballUuid);
    }
    await _init();
    isBallLoaded = true;
    notifyListeners();
  }

  _init() async {
    _googleMapInitPosition = CameraPosition(
        target: LatLng(this.fBallResDto.latitude, this.fBallResDto.longitude),
        zoom: 14.4);

    var position = await _geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPosition();

    mapMarkers.add(Marker(
        zIndex: 1,
        markerId: MarkerId("User"),
        position: LatLng(position.latitude, position.longitude),
        icon: _mapMakerDescriptorContainer
            .getBitmapDescriptor(MapMakerDescriptorType.UserAvatarIcon)));

    mapMarkers.add(Marker(
        zIndex: 2,
        markerId: MarkerId(this.fBallResDto.ballUuid),
        position: LatLng(this.fBallResDto.latitude, this.fBallResDto.longitude),
        icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
            MapMakerDescriptorType.IssueBallIconSelectNormal)));
  }

  get isShowBottomSheet {
    if (this.sheetController.state != null &&
        this.sheetController.state.isCollapsed) {
      return false;
    } else {
      return true;
    }
  }

  getBottomSheet() {
    return _bottomWidget;
  }

  get middleSnapPosition {
    return MediaQuery.of(_context).size.height * 0.45;
  }

  get topSnapPosition {
    return MediaQuery.of(_context).size.height -
        (MediaQuery.of(_context).padding.top + 58);
  }

  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    final RenderBox mapRenderBoxRed =
        mapContainerGlobalKey.currentContext.findRenderObject();

    var latLng =
        await _mapScreenPositionUseCaseInputPort.mapScreenOffsetToLatLng(
            mapRenderBoxRed,
            controller,
            MediaQuery.of(_context).size.width / 2,
            MediaQuery.of(_context).size.height * 0.7);

    googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 14)));
  }

  void listenerState(SheetState state) {
    if (state.isCollapsed) {
      _currentCollapsed = true;
      notifyListeners();
    }
    if (_currentCollapsed && !state.isCollapsed) {
      _currentCollapsed = false;
      notifyListeners();
    }
  }
}
