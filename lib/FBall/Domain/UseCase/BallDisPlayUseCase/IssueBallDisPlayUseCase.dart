import 'dart:convert';

import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'BallDisPlayUseCase.dart';

class IssueBallDisPlayUseCase extends BallDisPlayUseCase {
  IssueBallDescription _issueBallDescription;
  FBallResDto _fBallResDto;
  IssueBallDisPlayUseCase(FBallResDto fBallResDto) : super(fBallResDto){
    _fBallResDto = fBallResDto;
    _issueBallDescription = IssueBallDescription.fromJson(json.decode(fBallResDto.description));
  }
  bool isMainPicture(){
    if(_fBallResDto.ballDeleteFlag){
      return false;
    }else {
      return _issueBallDescription.desimages.length > 0;
    }

  }
  String mainPictureSrc(){
    if(_fBallResDto.ballDeleteFlag){
      return null;
    }else {
      return _issueBallDescription.desimages[0].src;
    }
  }

  int pictureCount() {
    if(_fBallResDto.ballDeleteFlag){
      return 0;
    }else {
      return _issueBallDescription.desimages.length;
    }
  }

  List<FBallDesImages> getDesImages() {
    if(_fBallResDto.ballDeleteFlag){
      return [];
    }else {
      return _issueBallDescription.desimages;
    }
  }

  String descriptionText() {
    if(_fBallResDto.ballDeleteFlag){
      return "";
    }else {
      return _issueBallDescription.text;
    }

  }


}