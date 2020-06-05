import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';


import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:meta/meta.dart';

class FBallRepositoryImpl implements FBallRepository {

  final FBallRemoteDataSource fBallRemoteDataSource;

  FBallRepositoryImpl({@required this.fBallRemoteDataSource});

  @override
  Future<FBallListUpWrap> listUpFromPosition({@required FBallListUpReqDto listUpReqDto}) async {
    var result = await fBallRemoteDataSource.listUpFromPosition(fBallListUpReqDto: listUpReqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto}) async {
    var result = await fBallRemoteDataSource.getUserToMakerBalls(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }
}