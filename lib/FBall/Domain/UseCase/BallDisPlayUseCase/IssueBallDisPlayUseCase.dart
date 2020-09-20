import 'dart:convert';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'BallDisPlayUseCase.dart';

class IssueBallDisPlayUseCase extends BallDisPlayUseCase {
  IssueBallDisPlayUseCase(
      {FBallResDto fBallResDto,
      GeolocatorAdapter
          geoLocatorAdapter}) {
    this.fBallResDto = fBallResDto;
    this.geoLocatorAdapter = geoLocatorAdapter;
    this.ballDescription =
        IssueBallDescription.fromJson(json.decode(fBallResDto.description));
  }
}
