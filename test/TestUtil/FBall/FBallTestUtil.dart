import 'package:forutonafront/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

import '../../fixtures/fixture_reader.dart';

class FBallTestUtil {
  static FBallResDto getBasicFBallResDto(
      String ballUuid, FUserInfoSimpleResDto fUserInfoSimpleResDto) {
    FBallResDto fBallResDto = new FBallResDto();
    fBallResDto.uid = fUserInfoSimpleResDto;
    fBallResDto.latitude = 37.508797;
    fBallResDto.longitude = 126.890605;
    fBallResDto.ballUuid = ballUuid;
    fBallResDto.ballType = FBallType.IssueBall;
    fBallResDto.ballName = "Test Ball";
    fBallResDto.ballPower = 10;
    fBallResDto.activationTime = DateTime.now().add(Duration(days: 7));
    fBallResDto.ballDeleteFlag = false;
    fBallResDto.description =
        fixtureString("FBall/Data/DataSource/package.json");
    fBallResDto.placeAddress = "서울 특별시 신도림";
    fBallResDto.makeTime = DateTime.now();
    fBallResDto.ballHits = 10;
    fBallResDto.commentCount = 10;
    fBallResDto.ballDisLikes = 10;
    fBallResDto.ballLikes = 20;
    fBallResDto.ballState = FBallState.Play;
    fBallResDto.contributor = 3;
    return fBallResDto;
  }
}
