
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallResDto.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MaliciousBallRepository)
class MaliciousBallRepositoryImpl implements MaliciousBallRepository {

  final FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter;

  MaliciousBallRepositoryImpl(this.fireBaseAuthBaseAdapter);

  @override
  Future<MaliciousBallResDto> save (MaliciousBallReqDto reqDto) async {
    var fDio = FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.post("/MaliciousBall",queryParameters: reqDto.toJson());
    return MaliciousBallResDto.fromJson(response.data);
  }

}