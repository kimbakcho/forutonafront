
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class FBallReplyRepository {
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto);
  Future<PageWrap<FBallReplyResDto>> getFBallReply(FBallReplyReqDto reqDto,Pageable pageable);
  Future<FBallReplyResDto> updateFBallReply(FBallReplyUpdateReqDto reqDto);
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid);
  Future<int?> getBallReviewCount(String ballUuid);
}