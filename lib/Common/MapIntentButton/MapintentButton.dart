import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/MapIntentButton/MapIntent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class MapIntentButton extends StatelessWidget {
  final Position _dstPosition;
  final String _dstAddress;

  MapIntentButton({
    required Position dstPosition,
    required String dstAddress,
  })  : _dstPosition = dstPosition,
        _dstAddress = dstAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 37,
      height: 37,
      decoration:
          BoxDecoration(
            border: Border.all(color: Color(0xff007EFF),width: 2),
              color: Colors.white, shape: BoxShape.circle
          ),
      child: FlatButton(
        onPressed: () async {

          List<MapIntent> mapIntents = [];
          mapIntents.add(MapIntentKakaoImpl(
              dstPosition: _dstPosition,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));
          mapIntents.add(MapIntentNaverImpl(
              dstPosition: _dstPosition,
              dstAddress: _dstAddress,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));
          mapIntents.add(MapIntentGoogleImpl(
              dstPosition: _dstPosition,
              geoLocationUtilForeGroundUseCaseInputPort: sl()));

          for (int i = 0; i < mapIntents.length; i++) {
            if (await mapIntents[i].canLunch()) {
              await mapIntents[i].lunch();
              break;
            }
          }
        },
        padding: EdgeInsets.only(left: 5),
        child: Icon(
          ForutonaIcon.get_directions,
          color: Color(0xff007EFF),
          size: 15,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
