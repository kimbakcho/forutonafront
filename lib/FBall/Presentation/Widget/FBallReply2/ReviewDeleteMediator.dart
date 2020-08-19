import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';

abstract class ReviewDeleteMediatorComponent {
  onDeleted(FBallReplyResDto fBallReplyResDto);
}

abstract class ReviewDeleteMediator {
  registerComponent(
      ReviewDeleteMediatorComponent reviewDeleteMediatorComponent);

  unregisterComponent(
      ReviewDeleteMediatorComponent reviewDeleteMediatorComponent);

  deleteReview(FBallReplyResDto fBallReplyResDto);
}

class ReviewDeleteMediatorImpl implements ReviewDeleteMediator {
  List<ReviewDeleteMediatorComponent> components = [];
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;

  ReviewDeleteMediatorImpl(
      {FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort;

  @override
  deleteReview(FBallReplyResDto fBallReplyResDto) async {
    FBallReplyResDto tempFBallReplyResDto = await this._fBallReplyUseCaseInputPort.deleteFBallReply(fBallReplyResDto.replyUuid);
    fBallReplyResDto.deleteFlag = tempFBallReplyResDto.deleteFlag;
    fBallReplyResDto.replyText = tempFBallReplyResDto.replyText;
    onAllDeleteSignal(fBallReplyResDto);
  }

  onAllDeleteSignal(FBallReplyResDto fBallReplyResDto) {
    components.forEach((element) {
      element.onDeleted(fBallReplyResDto);
    });
  }

  @override
  registerComponent(
      ReviewDeleteMediatorComponent reviewDeleteMediatorComponent) {
    components.add(reviewDeleteMediatorComponent);
  }

  @override
  unregisterComponent(
      ReviewDeleteMediatorComponent reviewDeleteMediatorComponent) {
    components.remove(reviewDeleteMediatorComponent);
  }
}
