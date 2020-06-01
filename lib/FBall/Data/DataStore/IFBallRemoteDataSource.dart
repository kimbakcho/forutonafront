
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:meta/meta.dart';
import '../../../Preference.dart';

abstract class IFBallRemoteDataSource {
  Future<FBallListUpWrap> listUpFromPosition(
    {@required FBallListUpReqDto fBallListUpReqDto,@required FDio fDio});
}

class FBallRemoteSourceImpl implements IFBallRemoteDataSource {

  @override
  Future<FBallListUpWrap> listUpFromPosition(
      {@required FBallListUpReqDto fBallListUpReqDto,@required FDio fDio}) async {
    var response = await fDio.get(
        "/v1/FBall/BallListUp",
        queryParameters: fBallListUpReqDto.toJson());
    return FBallListUpWrap.fromJson(response.data);
  }

}