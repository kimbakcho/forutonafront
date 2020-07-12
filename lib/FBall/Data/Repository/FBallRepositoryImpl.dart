import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:meta/meta.dart';

class FBallRepositoryImpl implements FBallRepository {
  final FBallRemoteDataSource _fBallRemoteDataSource;

  FBallRepositoryImpl({@required FBallRemoteDataSource fBallRemoteDataSource})
      : _fBallRemoteDataSource = fBallRemoteDataSource;

  @override
  Future<FBallListUpWrap> listUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto) async {
    var result = await _fBallRemoteDataSource.listUpFromInfluencePower(
        listUpReqDto, FDio.noneToken());
    return result;
  }

  @override
  Future<UserToMakeBallWrap> getUserToMakerBalls(
      {@required UserToMakeBallReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.getUserToMakerBalls(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpFromSearchTitle(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpFromTagName(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> ballListUpFromMapArea(
      {@required BallFromMapAreaReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpBallFromMapArea(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }
}
