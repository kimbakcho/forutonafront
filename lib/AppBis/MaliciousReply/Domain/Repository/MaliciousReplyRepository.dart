
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyResDto.dart';

abstract class MaliciousReplyRepository{
  Future<MaliciousReplyResDto> save(MaliciousReplyReqDto reqDto);
}