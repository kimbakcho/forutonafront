import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/ReportActionAlertDialog/ReportActionAlertDialog.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001Mode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:uuid/uuid.dart';

import 'ID01Component/ID01Option/BallDeletePopup/BallDeletePopup.dart';
import 'ID01Component/ID01Option/MyBallPopup/MyBallPopup.dart';
import 'ID01MainBottomSheet/ID01MainBottomSheetHeader.dart';
import 'ID01MainBottomSheet/ID01MainBottomSheetBody.dart';
import 'ID01MainBottomSheet/ID01MainScaffoldBottomSheet.dart';
import 'ID01Mode.dart';

class ID01MainPage extends StatelessWidget {
  final String ballUuid;

  final FBallResDto fBallResDto;

  final ID01Mode id01Mode;

  final FBallResDto preViewResDto;

  final List<BallImageItem> preViewBallImage;

  final List<FBallTagResDto> preViewfBallTagResDtos;

  final Function onCreateBall;

  const ID01MainPage(
      {Key key,
      this.ballUuid,
      this.fBallResDto,
      this.id01Mode = ID01Mode.publish,
      this.preViewResDto,
      this.preViewBallImage,
      this.onCreateBall,
      this.preViewfBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainPageViewModel(
          context,
          ballUuid,
          fBallResDto,
          sl(),
          sl(),
          sl(),
          sl(),
          ValuationMediatorImpl(fBallValuationUseCaseInputPort: sl()),
          sl(),
          sl(),
          sl(),
          sl(),
          id01Mode: id01Mode,
          onCreateBall: onCreateBall,
          preViewResDto: preViewResDto),
      child: Consumer<ID01MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
              key: Key(model.mainkey),
              bottomSheet: model.isShowBottomSheet
                  ? ID01MainScaffoldBottomSheet(
                      fBallResDto: fBallResDto,
                      valuationMediator: model.valuationMediator)
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
                              onTap: () {
                                Navigator.of(context).pop();
                              },
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
                              onTap: () {
                                model.showPopup(context);
                              },
                            ),
                          ),
                          model._currentExpanded
                              ? Container(
                                  color: Colors.black.withOpacity(0.4),
                                )
                              : Container(
                                  width: 0,
                                  height: 0,
                                )
                        ],
                      ),
                      minHeight: 100,
                      builder: (context, state) {
                        return ID01MainBottomSheetBody(
                          topPosition: model.topSnapPosition,
                          fBallResDto: model.fBallResDto,
                          id01Mode: id01Mode,
                          preViewBallImage: preViewBallImage,
                          preViewfBallTagResDtos: preViewfBallTagResDtos,
                        );
                      },
                      headerBuilder: (context, state) {
                        return ID01MainBottomSheetHeader(
                            fBallResDto: model.fBallResDto);
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

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final MaliciousBallUseCaseInputPort _maliciousBallUseCaseInputPort;

  final ID01Mode id01Mode;

  final FBallResDto preViewResDto;

  final Function onCreateBall;

  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;

  final DeleteBallUseCaseInputPort _deleteBallUseCaseInputPort;

  ID01MainBottomSheetBodyController _id01mainBottomSheetBodyController;

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

  bool _currentExpanded = false;

  ValuationMediator valuationMediator;

  String mainkey;

  ID01MainPageViewModel(
    this._context,
    this.ballUuid,
    this.fBallResDto,
    this._selectBallUseCaseInputPort,
    this._geoLocationUtilForeGroundUseCaseInputPort,
    this._mapMakerDescriptorContainer,
    this._mapScreenPositionUseCaseInputPort,
    this.valuationMediator,
    this._signInUserInfoUseCaseInputPort,
    this._maliciousBallUseCaseInputPort,
    this._tagFromBallUuidUseCaseInputPort,
    this._deleteBallUseCaseInputPort, {
    this.id01Mode,
    this.preViewResDto,
    this.onCreateBall,
  }) {
    mainkey = Uuid().v4();
    _id01mainBottomSheetBodyController = ID01MainBottomSheetBodyController();
    sheetController = SheetController();
    this._loadBall();
  }

  _loadBall() async {
    isBallLoaded = false;

    if (id01Mode == ID01Mode.preview) {
      this.fBallResDto = preViewResDto;
      notifyListeners();
    } else {
      if (fBallResDto == null) {
        notifyListeners();
        this.fBallResDto =
            await this._selectBallUseCaseInputPort.selectBall(ballUuid);
      }
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

    await Future.delayed(Duration(milliseconds: 500));

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
    if (state.progress == 1.0) {
      if (_currentExpanded == false) {
        _currentExpanded = true;
        notifyListeners();
      }
    } else {
      if (_currentExpanded == true) {
        _currentExpanded = false;
        notifyListeners();
      }
    }
  }

  showPopup(BuildContext context) async {
    var reqSignInUserInfoFromMemory =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    if (fBallResDto.uid.uid == reqSignInUserInfoFromMemory.uid) {
      showDialog(
          context: context,
          child: MyBallPopup(
            onDelete: onDeleteBall,
            onModify: onModifyBall,
          ));
    } else {
      await showDialog(
          context: context,
          child: MaliciousReportActionAlertDialog(
            onReportMalicious: onReportMalicious,
          ));
    }
  }

  onDeleteBall(BuildContext context) async {
    await showDialog(context: context, child: BallDeletePopup(
      actionDelete:onActionDelete,
    ));

  }
  onActionDelete() async {
    await _deleteBallUseCaseInputPort.deleteBall(fBallResDto.ballUuid);
    Navigator.of(_context).pop();
    Navigator.of(_context).pop();
  }

  onModifyBall(BuildContext context) async {
    var tags = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: fBallResDto.ballUuid);

    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return IM001MainPage(
        preSetBallResDto: fBallResDto,
        im001mode: IM001Mode.modify,
        preSetFBallTagResDtos: tags,
      );
    }));
    this.fBallResDto =
        await this._selectBallUseCaseInputPort.selectBall(ballUuid);
    mainkey = Uuid().v4();
    notifyListeners();
  }

  onReportMalicious(MaliciousType maliciousType) async {
    await this
        ._maliciousBallUseCaseInputPort
        .reportMaliciousReply(maliciousType, ballUuid);
  }
}
