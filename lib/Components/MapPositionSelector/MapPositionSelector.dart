import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
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

class MapPositionSelector extends StatelessWidget {
  final Function(CameraPosition)? onMoveMap;

  final CameraPosition initCameraPosition;

  final MapPositionSelectorController? controller;

  final String iconPath;

  MapPositionSelector(
      {this.onMoveMap,
      required this.initCameraPosition,
      this.controller,
      required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapPositionSelectorViewModel(
          context: context,
          initCameraPosition: initCameraPosition,
          controller: controller,
          onMoveMap: onMoveMap),
      child: Consumer<MapPositionSelectorViewModel>(
        builder: (_, model, child) {
          return Container(
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
                            model.gotoAddressSearchPage(context);
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
                        // myLocationEnabled: true,
                        // myLocationButtonEnabled: true,
                        initialCameraPosition: model.initCameraPosition,
                        onCameraMove: model.onCameraMove,
                        onMapCreated: model.onCreateMap,
                        onCameraIdle: model.onCameraIdle,
                        zoomControlsEnabled: false,
                      ),
                      Center(
                          child: IgnorePointer(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 40,left: 14),
                                  height: 40,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                          image: AssetImage(iconPath)))))),
                      Positioned(
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
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 71),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapPositionSelectorViewModel extends ChangeNotifier
    implements InputSearchBarListener, PlaceListFromSearchTextWidgetListener {
  final Function(CameraPosition)? onMoveMap;

  BuildContext context;

  late CameraPosition currentPosition;

  final CameraPosition initCameraPosition;

  Completer<GoogleMapController> _googleMapController = Completer();

  final MapPositionSelectorController? controller;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase = sl();

  MapPositionSelectorViewModel(
      {required this.context,
      this.onMoveMap,
      required this.initCameraPosition,
      this.controller}) {
    if (this.controller != null) {
      this.controller!._viewModel = this;
    }
    this.currentPosition = initCameraPosition;
  }

  void gotoAddressSearchPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return H010MainView(
          inputSearchBarListener: this,
          searchHistoryDataSourceKey:
              SearchHistoryDataSourceKey.AddressSearchHistoryDataSource);
    }));
  }

  @override
  Future<void>? onSearch(String search, {required BuildContext context}) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return H008MainView(
          initSearchText: search, placeListFromSearchTextWidgetListener: this);
    }));
  }

  @override
  onPlaceListTabPosition(Position position) async {
    Navigator.of(context).pop();
    GoogleMapController mapController = await _googleMapController.future;
    var cameraPosition = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    if (onMoveMap != null) {
      onMoveMap!(cameraPosition);
    }
  }

  void onCameraMove(CameraPosition position) async {
    currentPosition = position;
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    if (onMoveMap != null) {
      onMoveMap!(initCameraPosition);
    }
  }

  void onCameraIdle() async {
    if (onMoveMap != null) {
      onMoveMap!(currentPosition);
    }
  }

  moveToMyPosition() async {
    var position =
        await _geoLocationUtilForeGroundUseCase.getCurrentWithLastPosition();
    GoogleMapController mapController = await _googleMapController.future;
    var cameraPosition = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}

class MapPositionSelectorController {
  MapPositionSelectorViewModel? _viewModel;

  MapPositionSelectorController();

  CameraPosition getCurrentPosition() {
    return _viewModel!.currentPosition;
  }
}
