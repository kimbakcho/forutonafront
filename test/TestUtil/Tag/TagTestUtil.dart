 import 'dart:math';

import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

class TagTestUtil {
    static FBallTagResDto makeBasicTagResDto(String tagName,FBallResDto fBallResDto){
      FBallTagResDto fBallTagResDto = FBallTagResDto();
      fBallTagResDto.ballUuid = fBallResDto;
      fBallTagResDto.tagItem = tagName;
      var rng = new Random();
      fBallTagResDto.idx  = rng.nextInt(100);
      return fBallTagResDto;
    }
 }