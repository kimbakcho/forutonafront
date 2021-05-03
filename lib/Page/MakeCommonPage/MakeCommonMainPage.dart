import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';

import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';

import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';

import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/Page/HCodePage/H008/H008MainView.dart';
import 'package:forutonafront/Page/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/Page/HCodePage/H010/H010MainView.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'MakePageMode.dart';
import 'MakeCommonBottomSheetHeader.dart';

class MakeCommonMainPage extends StatelessWidget {
  final MakePageMode makePageMode;
  final Widget makeBottomBodySheet;
  final Widget makeOpenBottomHeaderSheet;
  final String ballIconPath;
  final Function(String)? onChangeDisplayAddress;
  final Position? preSetPosition;
  final String? preSetAddress;
  final MakeCommonMainPageController? makeCommonMainPageController;

  MakeCommonMainPage(
      {Key? key,
      required this.makePageMode,
      required this.makeBottomBodySheet,
      required this.ballIconPath,
      required this.makeOpenBottomHeaderSheet,
      this.makeCommonMainPageController,
      this.preSetPosition,
      this.preSetAddress,
      this.onChangeDisplayAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MakeCommonMainPageViewModel(context, sl(),
            makePageMode: makePageMode,
            makeBottomBodySheet: makeBottomBodySheet,
            onChangeDisplayAddress: onChangeDisplayAddress,
            makeCommonMainPageController: makeCommonMainPageController,
            preSetPosition: preSetPosition,
            preSetAddress: preSetAddress,
            openHeaderWidget: makeOpenBottomHeaderSheet),
        child:
            Consumer<MakeCommonMainPageViewModel>(builder: (_, model, child) {
          return Scaffold(

              body: SlidingUpPanel(

            panel: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.only(bottom: max(MediaQuery.of(context).viewInsets.bottom-26,0)),
              child: makeBottomBodySheet,
            ),
            controller: model.panelController,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top-3,
            body: Container(
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(children: [
                        SizedBox(width: 16),
                        Material(
                          color: Color(0xffF6F6F6),
                          shape: CircleBorder(),
                          child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            child: Material(
                          color: Color(0xffF6F6F6),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            onTap: () {
                              model.gotoAddressSearchPage();
                            },
                            child: Container(
                              height: 36,
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "주소 검색",
                                style: GoogleFonts.notoSans(
                                    color: Color(0xffB1B1B1)),
                              ),
                            ),
                          ),
                        )),
                        SizedBox(width: 16),
                      ])),
                  Expanded(
                      child: Container(
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: model.initCameraPosition,
                          onCameraMove: model.onCameraMove,
                          onMapCreated: model.onCreateMap,
                          onCameraIdle: model.onCameraIdle,
                          zoomControlsEnabled: false,
                        ),
                        Center(
                            child: IgnorePointer(
                                child: Container(
                                    height: 60,
                                    width: 43,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(ballIconPath)))))),
                        makePageMode == MakePageMode.create
                            ? Positioned(
                                right: 16,
                                top: 16,
                                child: CircleIconBtn(
                                  color: Colors.white,
                                  width: 36,
                                  height: 36,
                                  onTap: () {
                                    model.moveToMyPosition();
                                  },
                                  icon: Icon(
                                    Icons.my_location,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(width: 0, height: 0)
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 71),
                  )),
                ],
              ),
            ),
            onPanelOpened: () {
              model.makeCommonBottomSheetHeaderController
                  .changeHeaderMode(MakeCommonBottomSheetHeaderMode.show);
            },
            onPanelClosed: () {
              model.makeCommonBottomSheetHeaderController
                  .changeHeaderMode(MakeCommonBottomSheetHeaderMode.hide);
            },
            backdropColor: Colors.black,
            backdropEnabled: true,
            header: MakeCommonBottomSheetHeader(
              onNextBtnTap: () {
                model.panelController.open();
              },
              openHeaderWidget: makeOpenBottomHeaderSheet,
              makePageMode: makePageMode,
              preSetAddress: preSetAddress,
              displayAddress: "로딩중",
              makeCommonBottomSheetHeaderController:
                  model.makeCommonBottomSheetHeaderController,
            ),
          ));
        }));
  }
}

class MakeCommonMainPageViewModel extends ChangeNotifier
    implements InputSearchBarListener, PlaceListFromSearchTextWidgetListener {
  late CameraPosition initCameraPosition;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase = sl();

  late CameraPosition currentPosition;

  Completer<GoogleMapController> _googleMapController = Completer();

  final BuildContext context;

  Widget openHeaderWidget;

  late MakeCommonBottomSheetHeader makeCommonBottomSheetHeader;

  MapBallMarkerFactory _mapBallMarkerFactory;

  String headBarAddress = "";

  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort = sl();

  final MakePageMode makePageMode;

  final Function(String)? onChangeDisplayAddress;

  Widget makeBottomBodySheet;

  final Position? preSetPosition;

  final String? preSetAddress;

  MakeCommonBottomSheetHeaderController makeCommonBottomSheetHeaderController = MakeCommonBottomSheetHeaderController();

  MakeCommonMainPageController? makeCommonMainPageController;

  PanelController panelController = PanelController();

  late Widget bottomSheet;


  MakeCommonMainPageViewModel(this.context, this._mapBallMarkerFactory,
      {required this.makePageMode,
      required this.openHeaderWidget,
      required this.makeBottomBodySheet,
      this.makeCommonMainPageController,
      this.preSetPosition,
      this.preSetAddress,
      this.onChangeDisplayAddress}) {
    headBarAddress = '로딩중';
    if (makeCommonMainPageController != null) {
      makeCommonMainPageController!._viewModel = this;
    }
    if (makePageMode == MakePageMode.create) {
      var currentWithLastPositionInMemory = _geoLocationUtilForeGroundUseCase
          .getCurrentWithLastPositionInMemory();
      initCameraPosition = new CameraPosition(
          zoom: 14.56,
          target: LatLng(currentWithLastPositionInMemory!.latitude!,
              currentWithLastPositionInMemory.longitude!));
      currentPosition = initCameraPosition;
    } else {
      initCameraPosition = new CameraPosition(
          zoom: 14.56,
          target:
              LatLng(preSetPosition!.latitude!, preSetPosition!.longitude!));
      currentPosition = initCameraPosition;
    }
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    Position position;
    if (makePageMode == MakePageMode.create) {
      position = await moveToMyPosition();
    } else {
      position = Position(
          latitude: preSetPosition!.latitude,
          longitude: preSetPosition!.longitude);
    }

    String address =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(position);
    print(address);
    if (onChangeDisplayAddress != null) {
      onChangeDisplayAddress!(address);
    }

    headBarAddress = address;

    makeCommonBottomSheetHeaderController.changeDisplayAddress(address);

    notifyListeners();
  }

  void onCameraIdle() async {
    var position2 = Position(
        latitude: currentPosition.target.latitude,
        longitude: currentPosition.target.longitude);
    String address =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(position2);
    if (onChangeDisplayAddress != null) {
      onChangeDisplayAddress!(address);
    }
    makeCommonBottomSheetHeaderController.changeDisplayAddress(address);
    notifyListeners();
  }

  moveToMyPosition() async {
    var position =
        await _geoLocationUtilForeGroundUseCase.getCurrentWithLastPosition();
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5)));
    return position;
  }

  void onCameraMove(CameraPosition position) async {
    currentPosition = position;
  }

  void gotoAddressSearchPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return H010MainView(
          inputSearchBarListener: this,
          searchHistoryDataSourceKey:
              SearchHistoryDataSourceKey.AddressSearchHistoryDataSource);
    }));
  }

  //지도 찾기
  @override
  Future<void> onSearch(String search, {BuildContext? context}) async {
    Navigator.of(this.context).pop();
    Navigator.of(this.context).push(MaterialPageRoute(builder: (_) {
      return H008MainView(
          initSearchText: search, placeListFromSearchTextWidgetListener: this);
    }));
  }

  @override
  onPlaceListTabPosition(Position position) async {
    Navigator.of(context).pop();
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5)));

    headBarAddress =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(position);
  }

  get isBottomOpened {
    return panelController.isPanelOpen;
  }
}

class MakeCommonMainPageController {
  MakeCommonMainPageViewModel? _viewModel;

  Position? getCurrentPosition() {
    if (_viewModel != null) {
      var currentPosition = _viewModel!.currentPosition;

      return Position(
          latitude: currentPosition.target.latitude,
          longitude: currentPosition.target.longitude);
    } else {
      return null;
    }
  }

  get isBottomOpened {
    if (_viewModel != null) {
      return _viewModel!.isBottomOpened;
    }else {
      return false;
    }
  }
}
