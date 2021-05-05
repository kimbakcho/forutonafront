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
import 'package:forutonafront/Components/MapPositionSelector/MapPositionSelector.dart';
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
  final String ballName;

  MakeCommonMainPage(
      {Key? key,
      required this.makePageMode,
      required this.makeBottomBodySheet,
      required this.ballIconPath,
      required this.makeOpenBottomHeaderSheet,
      this.makeCommonMainPageController,
      this.preSetPosition,
      this.preSetAddress,
      this.onChangeDisplayAddress,required this.ballName})
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
                padding: MediaQuery.of(context).viewInsets.bottom > 100 ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : EdgeInsets.zero,

            panel: Container(
              margin:  EdgeInsets.only(top: 50),
              padding: EdgeInsets.only(bottom: max(MediaQuery.of(context).viewInsets.bottom-26,0)),
              child: makeBottomBodySheet,
            ),
            controller: model.panelController,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top-3,
            body: MapPositionSelector(
              iconPath: ballIconPath,
              initCameraPosition: model.initCameraPosition,
              controller: model.mapPositionSelectorController,
              onMoveMap: model.onMoveMap,
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
              ballName: ballName,
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

class MakeCommonMainPageViewModel extends ChangeNotifier {
  late CameraPosition initCameraPosition;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase = sl();

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

  MapPositionSelectorController mapPositionSelectorController = MapPositionSelectorController();


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
    } else {
      initCameraPosition = new CameraPosition(
          zoom: 14.56,
          target:
              LatLng(preSetPosition!.latitude!, preSetPosition!.longitude!));
    }
  }

  onMoveMap(CameraPosition position) async {

    Position newPosition = Position(
      longitude: position.target.longitude,
      latitude:  position.target.latitude
    ) ;
    String address =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(newPosition);
    print(address);
    if (onChangeDisplayAddress != null) {
      onChangeDisplayAddress!(address);
    }

    headBarAddress = address;

    makeCommonBottomSheetHeaderController.changeDisplayAddress(address);

    notifyListeners();
  }

  get isBottomOpened {
    return panelController.isPanelOpen;
  }

  Position getCurrentPosition(){
    var currentPosition = mapPositionSelectorController.getCurrentPosition();
    Position newPosition = Position(
      latitude: currentPosition.target.latitude,
      longitude:  currentPosition.target.longitude
    );
    return newPosition;
  }

}

class MakeCommonMainPageController {
  MakeCommonMainPageViewModel? _viewModel;

  Position? getCurrentPosition() {
    if (_viewModel != null) {
      return _viewModel!.getCurrentPosition();
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
