import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ID01AddressWidget extends StatelessWidget {
  final FBallResDto fBallResDto;

  final EdgeInsets padding;

  const ID01AddressWidget({Key key, this.fBallResDto, this.padding = const EdgeInsets.fromLTRB(8, 0, 62, 0)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01AddressWidgetViewModel(fBallResDto, sl()),
      child: Consumer<ID01AddressWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 37,
            child: Row(
              children: [
                Icon(Icons.location_on),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 6),
                  child: Text(fBallResDto.placeAddress,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff454f63),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w500,
                      )),
                )),
                Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  height: 19,
                  width: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffE4E7E8),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child:
                      Text(model.loaded ? model.displayDistanceWithUser : "계산중",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xffff5d76),
                            letterSpacing: -0.28,
                            fontWeight: FontWeight.w500,
                          )),
                )
              ],
            ),
            padding: padding,
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        },
      ),
    );
  }
}

class ID01AddressWidgetViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;

  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCaseInputPort;

  bool loaded = false;

  String displayDistanceWithUser;

  ID01AddressWidgetViewModel(
      this.fBallResDto, this._geoLocationUtilForeGroundUseCaseInputPort) {
    this.init();
  }

  init() async {
    loaded = false;
    notifyListeners();
    Position ballPosition = new Position(
        longitude: fBallResDto.longitude, latitude: fBallResDto.latitude);
    this.displayDistanceWithUser =
        await _geoLocationUtilForeGroundUseCaseInputPort
            .reqBallDistanceDisplayText(ballLatLng: ballPosition);
    loaded = true;
    notifyListeners();
  }
}
