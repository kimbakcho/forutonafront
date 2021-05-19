import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/MapIntentButton/MapintentButton.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/DetailPage/DBallAddressWidget.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DetailMap extends StatelessWidget {
  final Position position;

  final String address;

  final Marker marker;

  DetailMap(
      {required this.position, required this.address, required this.marker});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailMapViewModel(
          position: position, marker: marker, address: address),
      child: Consumer<DetailMapViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    GoogleMap(
                        initialCameraPosition: model.initCameraPosition,
                        markers: model.mapMarker,
                        myLocationButtonEnabled: false,
                        onMapCreated: model.onMapCreated,
                        zoomControlsEnabled: false,
                        myLocationEnabled: false),
                    Positioned(
                        top: MediaQuery.of(context).padding.top + 16,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                                children: [
                                  SizedBox(width: 16),
                                  CircleIconBtn(
                                    width: 36,
                                    height: 36,
                                    color: Colors.white,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    isBoxShadow: true,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  CircleIconBtn(
                                    width: 36,
                                    height: 36,
                                    color: Colors.white,
                                    onTap: () {
                                      model.moveMyPosition();
                                    },
                                    isBoxShadow: true,
                                    icon: Icon(
                                      Icons.my_location_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                ]),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Spacer(),
                                CircleIconBtn(
                                  height: 36,
                                  width: 36,
                                  color: Colors.white,
                                  isBoxShadow: true,
                                  icon: Icon(ForutonaIcon.mappin1,color: Colors.black,size: 15,),
                                  onTap: (){
                                    model.movePosition(position);
                                  },
                                ),
                                SizedBox(width: 16,),
                              ],
                            )
                          ],
                        ))
                  ],
                )),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                          child: DBallAddressWidget(
                            padding: EdgeInsets.only(right: 16),
                        address: address,
                        position: position,
                            onTabAddress: (tapPosition){
                              model.movePosition(tapPosition);
                            },
                      )),
                      MapIntentButton(
                        dstPosition: position,
                        dstAddress: address,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailMapViewModel extends ChangeNotifier {
  final Position position;

  final String address;

  final Marker marker;

  late CameraPosition currentCameraPosition;

  late CameraPosition initCameraPosition;

  GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCaseInputPort = sl();

  MapMakerDescriptorContainer _makerDescriptorContainer = sl();

  Completer<GoogleMapController> _googleMapController = Completer();

  Set<Marker> mapMarker = Set<Marker>();

  DetailMapViewModel(
      {required this.position, required this.address, required this.marker}) {
    initCameraPosition = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.4);
    this.currentCameraPosition = initCameraPosition;
    _loadMaker();
  }

  _loadMaker() async {
    mapMarker.add(marker);
    var currentWithLastPosition =
        await _geoLocationUtilForeGroundUseCaseInputPort
            .getCurrentWithLastPosition();
    var userAvatarIcon = _makerDescriptorContainer
        .getBitmapDescriptor(MapMakerDescriptorType.UserAvatarIcon);
    mapMarker.add(Marker(
        markerId: MarkerId("userIcon"),
        position: LatLng(currentWithLastPosition.latitude!,
            currentWithLastPosition.longitude!),
        icon: userAvatarIcon));
    notifyListeners();
  }

  onMapCreated(GoogleMapController controller){
    _googleMapController.complete(controller);
  }

  void moveMyPosition() async {
    var currentWithLastPosition =
        await _geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPosition();
    final GoogleMapController controller = await _googleMapController.future;
    var newCameraPosition = CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentWithLastPosition.latitude!,currentWithLastPosition.longitude!),
        zoom: 14.4
    ));
    controller.animateCamera(newCameraPosition);
  }

  void movePosition(Position position) async{
    final GoogleMapController controller = await _googleMapController.future;
    var newCameraPosition = CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude!,position.longitude!),
        zoom: 14.4
    ));
    controller.animateCamera(newCameraPosition);
  }
}
