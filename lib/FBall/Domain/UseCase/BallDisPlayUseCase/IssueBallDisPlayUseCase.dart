import 'dart:convert';

import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'BallDisPlayUseCase.dart';

class IssueBallDisPlayUseCase extends BallDisPlayUseCase {
  IssueBallDisPlayUseCase({FBallResDto fBallResDto}) {
    this.fBallResDto = fBallResDto;
    this.ballDescription = IssueBallDescription.fromJson(json.decode(fBallResDto.description));
  }
}