import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/MapIntentButton/MapIntent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class MapIntentButton extends StatelessWidget {
  final Position _dstPosition;
  final String _dstAddress;
  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCaseInputPort;

  MapIntentButton(
      {@required
          Position dstPosition,
      @required
          String dstAddress,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilForeGroundUseCaseInputPort})
      : _dstPosition = dstPosition,
        _dstAddress = dstAddress,
        _geoLocationUtilForeGroundUseCaseInputPort =
            geoLocationUtilForeGroundUseCaseInputPort;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Color(0xff007EFF), shape: BoxShape.circle),
      child: FlatButton(
        onPressed: () async {
          List<MapIntent> mapIntents = List<MapIntent>();
          mapIntents.add(MapIntentGoogleImpl(
              dstPosition: _dstPosition,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));
          mapIntents.add(MapIntentKakaoImpl(
              dstPosition: _dstPosition,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));
          mapIntents.add(MapIntentNaverImpl(
              dstPosition: _dstPosition,
              dstAddress: _dstAddress,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));


          for(int i=0;i<mapIntents.length;i++){
            if (await mapIntents[i].canLunch()) {
              await mapIntents[i].lunch();
              break;
            }
          }

        },
        padding: EdgeInsets.all(0),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
