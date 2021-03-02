
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart';

import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyResDto.dart';
import 'package:injectable/injectable.dart';

abstract class  MaliciousReplyUseCaseInputPort {
   Future<MaliciousReplyResDto> reportMaliciousReply(MaliciousType replyMaliciousType, String replyUuid);
}
@LazySingleton(as: MaliciousReplyUseCaseInputPort)
class MaliciousReplyUseCase implements MaliciousReplyUseCaseInputPort{

  final MaliciousReplyRepository _maliciousReplyRepository;

  MaliciousReplyUseCase(this._maliciousReplyRepository);

  @override
  Future<MaliciousReplyResDto> reportMaliciousReply(MaliciousType replyMaliciousType, String replyUuid) async {

    MaliciousReplyReqDto replyReqDto = new MaliciousReplyReqDto();

    replyReqDto.etc = 0;
    replyReqDto.abuse = 0;
    replyReqDto.advertising = 0;
    replyReqDto.crime = 0;
    replyReqDto.privacy = 0;
    replyReqDto.sexual = 0;

    switch(replyMaliciousType){
      case MaliciousType.abuse:
        replyReqDto.abuse = 1;
        break;
      case MaliciousType.advertising:
        replyReqDto.advertising = 1;
        break;
      case MaliciousType.crime:
        replyReqDto.crime= 1;
        break;
      case MaliciousType.etc:
        replyReqDto.etc= 1;
        break;
      case MaliciousType.privacy:
        replyReqDto.privacy= 1;
        break;
      case MaliciousType.sexual:
        replyReqDto.sexual= 1;
        break;
    }

    replyReqDto.replyUuid = replyUuid;

    var maliciousReplyResDto = await _maliciousReplyRepository.save(replyReqDto);
    return maliciousReplyResDto;
  }

}