import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';

abstract class FBallReplyUseCaseOutputPort {
  onFBallReply(List<FBallReplyResDto> fBallResDto);
  onFBallReplyTotalCount(int totalCount);
}