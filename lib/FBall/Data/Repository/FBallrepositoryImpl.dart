import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/IFBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/IFBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:meta/meta.dart';

class FBallrepositoryImpl implements IFBallRepository {

  final IFBallRemoteDataSource ifBallRemoteDataSource;
  FDio _noneTokenFDio = new FDio("None");

  FBallrepositoryImpl({@required this.ifBallRemoteDataSource});


  @override
  Future<FBallListUpWrap> listUpFromPosition({@required FBallListUpReqDto listUpReqDto}) async {

    var result = await ifBallRemoteDataSource.listUpFromPosition(fBallListUpReqDto: listUpReqDto, fDio: _noneTokenFDio);
    return result;
  }
}