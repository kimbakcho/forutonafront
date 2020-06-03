import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/IFBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Value/FBallListUpWrap.dart';

import 'package:forutonafront/FBall/Domain/Repository/IFBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:meta/meta.dart';

class FBallrepositoryImpl implements IFBallRepository {

  final IFBallRemoteDataSource ifBallRemoteDataSource;

  FBallrepositoryImpl({@required this.ifBallRemoteDataSource});

  @override
  Future<FBallListUpWrap> listUpFromPosition({@required FBallListUpReqDto listUpReqDto}) async {

    var result = await ifBallRemoteDataSource.listUpFromPosition(fBallListUpReqDto: listUpReqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }
}