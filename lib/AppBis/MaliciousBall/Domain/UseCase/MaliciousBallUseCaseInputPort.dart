import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallResDto.dart';
import 'package:injectable/injectable.dart';

abstract class MaliciousBallUseCaseInputPort {
  Future<MaliciousBallResDto> reportMaliciousReply(MaliciousType ballMaliciousType, String ballUuid);
}

@LazySingleton(as: MaliciousBallUseCaseInputPort)
class MaliciousBallUseCase implements MaliciousBallUseCaseInputPort{

  final MaliciousBallRepository _maliciousBallRepository;

  MaliciousBallUseCase(this._maliciousBallRepository);

  @override
  Future<MaliciousBallResDto> reportMaliciousReply(MaliciousType ballMaliciousType, String ballUuid) async {

    MaliciousBallReqDto maliciousBallReqDto = new MaliciousBallReqDto();

    maliciousBallReqDto.ballUuid  = ballUuid;

    maliciousBallReqDto.etc = 0;
    maliciousBallReqDto.abuse = 0;
    maliciousBallReqDto.advertising = 0;
    maliciousBallReqDto.crime = 0;
    maliciousBallReqDto.privacy = 0;
    maliciousBallReqDto.sexual = 0;

    switch(ballMaliciousType){
      case MaliciousType.abuse:
        maliciousBallReqDto.abuse = 1;
        break;
      case MaliciousType.advertising:
        maliciousBallReqDto.advertising = 1;
        break;
      case MaliciousType.crime:
        maliciousBallReqDto.crime= 1;
        break;
      case MaliciousType.etc:
        maliciousBallReqDto.etc= 1;
        break;
      case MaliciousType.privacy:
        maliciousBallReqDto.privacy= 1;
        break;
      case MaliciousType.sexual:
        maliciousBallReqDto.sexual= 1;
        break;
    }

    MaliciousBallResDto maliciousBallResDto = await _maliciousBallRepository.save(maliciousBallReqDto);

    return maliciousBallResDto;
  }

}

