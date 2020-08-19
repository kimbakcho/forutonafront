import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class ReviewUpdateMediatorComponent {
  onUpdated(FBallReplyResDto fBallReplyResDto);
}

abstract class ReviewUpdateMediator {
  registerComponent(
      ReviewUpdateMediatorComponent reviewUpdateMediatorComponent);

  unregisterComponent(
      ReviewUpdateMediatorComponent reviewUpdateMediatorComponent);

  updateReView(FBallReplyUpdateReqDto fBallReplyUpdateReqDto);
}

class ReviewUpdateMediatorImpl extends ReviewUpdateMediator {
  @override
  registerComponent(ReviewUpdateMediatorComponent reviewUpdateMediatorComponent) {
    //TODO ReviewUpdateMediatorImpl 구현이 필요함.
    // TODO: implement registerComponent
    throw UnimplementedError();
  }

  @override
  unregisterComponent(ReviewUpdateMediatorComponent reviewUpdateMediatorComponent) {
    // TODO: implement unregisterComponent
    throw UnimplementedError();
  }

  @override
  updateReView(FBallReplyUpdateReqDto fBallReplyUpdateReqDto) {
    // TODO: implement updateReView
    throw UnimplementedError();
  }

}