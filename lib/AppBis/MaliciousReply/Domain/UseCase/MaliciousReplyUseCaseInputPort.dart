
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyResDto.dart';
import 'package:injectable/injectable.dart';

abstract class  MaliciousReplyUseCaseInputPort {
   Future<MaliciousReplyResDto> reportMaliciousReply(ReplyMaliciousType replyMaliciousType, String replyUuid);
}
@LazySingleton(as: MaliciousReplyUseCaseInputPort)
class MaliciousReplyUseCase implements MaliciousReplyUseCaseInputPort{

  final MaliciousReplyRepository _maliciousReplyRepository;

  MaliciousReplyUseCase(this._maliciousReplyRepository);

  @override
  Future<MaliciousReplyResDto> reportMaliciousReply(ReplyMaliciousType replyMaliciousType, String replyUuid) async {

    MaliciousReplyReqDto replyReqDto = new MaliciousReplyReqDto();

    replyReqDto.etc = 0;
    replyReqDto.abuse = 0;
    replyReqDto.advertising = 0;
    replyReqDto.crime = 0;
    replyReqDto.privacy = 0;
    replyReqDto.sexual = 0;


    switch(replyMaliciousType){
      case ReplyMaliciousType.abuse:
        replyReqDto.abuse = 1;
        break;
      case ReplyMaliciousType.advertising:
        replyReqDto.advertising = 1;
        break;
      case ReplyMaliciousType.crime:
        replyReqDto.crime= 1;
        break;
      case ReplyMaliciousType.etc:
        replyReqDto.etc= 1;
        break;
      case ReplyMaliciousType.privacy:
        replyReqDto.privacy= 1;
        break;
      case ReplyMaliciousType.sexual:
        replyReqDto.sexual= 1;
        break;
    }

    replyReqDto.replyUuid = replyUuid;

    var maliciousReplyResDto = await _maliciousReplyRepository.save(replyReqDto);
    return maliciousReplyResDto;
  }

}