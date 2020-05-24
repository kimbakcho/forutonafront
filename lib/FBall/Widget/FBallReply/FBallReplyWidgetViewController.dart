import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

import 'FBallReplyContentBar.dart';

class FBallReplyWidgetViewController {
  FBallReplyResWrapDto fBallReplyResWrapDto;
  List<FBallReplyContentBar> replyContentBars = [];
  FBallReplyWidgetViewController(this.fBallReplyResWrapDto,
      this.replyContentBars);
}