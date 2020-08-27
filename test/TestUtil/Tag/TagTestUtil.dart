 import 'dart:math';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';

class TagTestUtil {
    static FBallTagResDto makeBasicTagResDto(String tagName,FBallResDto fBallResDto){
      FBallTagResDto fBallTagResDto = FBallTagResDto();
      fBallTagResDto.ballUuid = fBallResDto;
      fBallTagResDto.tagItem = tagName;
      var rng = new Random();
      fBallTagResDto.idx  = rng.nextInt(100);
    }
 }