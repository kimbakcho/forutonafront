import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

import 'FBallReplyUseCaseOutputPort.dart';


abstract class FBallReplyUseCaseInputPort {
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<PageWrap<FBallReplyResDto>> reqFBallReply(FBallReplyReqDto reqDto,Pageable pageable,{FBallReplyUseCaseOutputPort outputPort});
  Future<FBallReplyResDto> updateFBallReply(FBallReplyUpdateReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid,{FBallReplyUseCaseOutputPort outputPort});
  Future<int> getBallReviewCount(String ballUuid);
}