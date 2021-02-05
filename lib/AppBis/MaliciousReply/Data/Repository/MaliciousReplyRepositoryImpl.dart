
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyResDto.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: MaliciousReplyRepository)
class MaliciousReplyRepositoryImpl implements MaliciousReplyRepository{

  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  MaliciousReplyRepositoryImpl(this._fireBaseAuthBaseAdapter);

  @override
  Future<MaliciousReplyResDto> save(MaliciousReplyReqDto reqDto) async{
    var fDio = FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken());
    var response = await fDio.post("/MaliciousReply",queryParameters: reqDto.toJson());
    return MaliciousReplyResDto.fromJson(response.data);
  }

}