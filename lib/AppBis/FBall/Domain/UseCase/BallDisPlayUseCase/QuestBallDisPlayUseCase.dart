import 'dart:convert';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallDescription.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'BallDisPlayUseCase.dart';

class QuestBallDisPlayUseCase extends BallDisPlayUseCase {
  QuestBallDisPlayUseCase(
      {required FBallResDto fBallResDto, GeolocatorAdapter?
          geoLocatorAdapter}) : super(fBallResDto, null, geoLocatorAdapter) {
    this.fBallResDto = fBallResDto;
    this.geoLocatorAdapter = geoLocatorAdapter;
    var description = fBallResDto.description;
    if(description != null){
      this.ballDescription =
          QuestBallDescription.fromJson(json.decode(description));
    }

  }
}
