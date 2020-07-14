import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

abstract class FBallReplyUseCaseOutputPort {
  onFBallReply(FBallReplyResWrapDto fBallResDto);
  onFBallReplyTotalCount(int totalCount);

  void onUpdateFBallReply(FBallReplyResDto fBallReplyResDto);

  void onInsertFBallReply(FBallReplyResDto fBallReplyResDto);

  void onDeleteFBallReply(FBallReplyResDto fBallReplyResDto);
}