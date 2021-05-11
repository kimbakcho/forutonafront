import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DBallMapStyle1 extends StatelessWidget {
  final FBallResDto fBallResDto;

  final Function? onTap;

  DBallMapStyle1({required this.fBallResDto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DBallMapStyle1ViewModel(fBallResDto: fBallResDto),
      child: Consumer<DBallMapStyle1ViewModel>(
        builder: (_, model, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: GoogleMap(
                    initialCameraPosition: model.initCameraPosition,
                    markers: model.markers,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DBallMapStyle1ViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;

  late CameraPosition initCameraPosition;

  final Set<Marker> markers = Set<Marker>();

  MapMakerDescriptorContainer _mapMakerDescriptorContainer = sl();

  DBallMapStyle1ViewModel({required this.fBallResDto}) {
    initCameraPosition = CameraPosition(
        target: LatLng(this.fBallResDto.latitude!, this.fBallResDto.longitude!),
        zoom: 14.4);
    _addCenterMarker();
  }

  _addCenterMarker() {
    if (fBallResDto.ballType == FBallType.IssueBall) {
      markers.add(Marker(
          position: LatLng(fBallResDto.latitude!, fBallResDto.longitude!),
          markerId: MarkerId(fBallResDto.ballUuid!),
          icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
              MapMakerDescriptorType.IssueBallIconSelectNormal)));
    } else if (fBallResDto.ballType == FBallType.QuestBall) {
      markers.add(Marker(
          position: LatLng(fBallResDto.latitude!, fBallResDto.longitude!),
          markerId: MarkerId(fBallResDto.ballUuid!),
          icon: _mapMakerDescriptorContainer.getBitmapDescriptor(
              MapMakerDescriptorType.QuestBallIconSelectNormal)));
    }
  }
}
