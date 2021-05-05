import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'MapPositionSelector.dart';

class MapPositionSelectorWithBottom extends StatelessWidget {
  final Function(CameraPosition)? onMoveMap;

  final CameraPosition initCameraPosition;

  final String iconPath;

  final Function(Position, String)? onSelectPosition;

  final String bottomTitle;

  final String bottomBtnText;

  MapPositionSelectorWithBottom(
      {this.onMoveMap,
      required this.initCameraPosition,
      required this.iconPath,
      required this.bottomTitle,
      required this.bottomBtnText,
      this.onSelectPosition});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapPositionSelectorWithBottomViewModel(
          onSelectPosition: onSelectPosition),
      child: Consumer<MapPositionSelectorWithBottomViewModel>(
        builder: (_, model, child) {
          return Stack(

            children: [
              MapPositionSelector(
                initCameraPosition: initCameraPosition,
                iconPath: iconPath,
                onMoveMap: (position) {
                  model.onMoveMap(position);
                  if (onMoveMap != null) {
                    onMoveMap!(position);
                  }
                },
                controller: model.controller,
              ),
              Positioned(
                  height: 113,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                      color: Colors.white,

                    ),
                    padding: EdgeInsets.only(top: 27),
                    height: 113,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "$bottomTitle",
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.28,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2142857142857142,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    model.address,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff3a3e3f),
                                      letterSpacing: -0.28,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2142857142857142,
                                    ),
                                  ),
                                )
                              ], crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                            TextButton(
                                onPressed: () {
                                  model.selectPosition();
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 16, 20, 16)),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                  )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xffE4E7E8))),
                                child: Container(
                                  child: Text(
                                    "$bottomBtnText",
                                    style: GoogleFonts.notoSans(
                                      fontSize: 16,
                                      color: const Color(0xff2f3035),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class MapPositionSelectorWithBottomViewModel extends ChangeNotifier {
  final Function(Position, String)? onSelectPosition;

  final MapPositionSelectorController controller =
      MapPositionSelectorController();

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase = sl();

  String address = "로딩중";

  MapPositionSelectorWithBottomViewModel({this.onSelectPosition});

  onMoveMap(CameraPosition? position) async {
    if (position != null) {
      Position newPosition = Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude);

      address = await _geoLocationUtilForeGroundUseCase
          .getPositionAddress(newPosition);
      notifyListeners();
    }
  }

  selectPosition() async {
    var currentPosition = controller.getCurrentPosition();
    Position position = Position(
        longitude: currentPosition.target.longitude,
        latitude: currentPosition.target.latitude);
    String address =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(position);

    if (onSelectPosition != null) {
      onSelectPosition!(position, address);
    }
  }
}
