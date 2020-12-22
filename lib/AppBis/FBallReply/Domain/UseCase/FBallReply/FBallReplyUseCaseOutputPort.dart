import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';


abstract class FBallReplyUseCaseOutputPort {
  onFBallReply(PageWrap<FBallReplyResDto> pageWrapReplys);
  onFBallReplyTotalCount(int totalCount);

  void onUpdateFBallReply(FBallReplyResDto fBallReplyResDto);

  void onInsertFBallReply(FBallReplyResDto fBallReplyResDto);

  void onDeleteFBallReply(FBallReplyResDto fBallReplyResDto);
}