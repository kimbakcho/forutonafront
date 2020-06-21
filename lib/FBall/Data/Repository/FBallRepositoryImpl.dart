import 'dart:typed_data';

import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';


import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:meta/meta.dart';

class FBallRepositoryImpl implements FBallRepository {

  final FBallRemoteDataSource fBallRemoteDataSource;

  FBallRepositoryImpl({@required this.fBallRemoteDataSource});

  @override
  Future<FBallListUpWrap> listUpFromInfluencePower({@required FBallListUpFromBallInfluencePowerReqDto listUpReqDto}) async {
    var result = await fBallRemoteDataSource.listUpFromInfluencePower(listUpReqDto,FDio.noneToken());
    return result;
  }

  @override
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto}) async {
    var result = await fBallRemoteDataSource.getUserToMakerBalls(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto}) async {
    var result = await fBallRemoteDataSource.listUpFromSearchTitle(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> listUpFromTagName({@required  FBallListUpFromTagNameReqDto reqDto}) async {
    var result = await fBallRemoteDataSource.listUpFromTagName(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<FBallListUpWrap> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto}) async {
    var result = await fBallRemoteDataSource.listUpBallFromMapArea(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }


}