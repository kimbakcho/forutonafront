import 'package:forutonafront/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBallReply/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class ReviewUpdateMediatorComponent {
  onUpdated(FBallReplyResDto fBallReplyResDto);
}

abstract class ReviewUpdateMediator {
  registerComponent(
      ReviewUpdateMediatorComponent reviewUpdateMediatorComponent);

  unregisterComponent(
      ReviewUpdateMediatorComponent reviewUpdateMediatorComponent);

  Future<FBallReplyResDto> updateReView(FBallReplyUpdateReqDto fBallReplyUpdateReqDto);
}

class ReviewUpdateMediatorImpl extends ReviewUpdateMediator {

  List<ReviewUpdateMediatorComponent> components = [];
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  ReviewUpdateMediatorImpl(
      {FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort;
  @override
  registerComponent(ReviewUpdateMediatorComponent reviewUpdateMediatorComponent) {
    components.add(reviewUpdateMediatorComponent);
  }

  @override
  unregisterComponent(ReviewUpdateMediatorComponent reviewUpdateMediatorComponent) {
    components.remove(reviewUpdateMediatorComponent);
  }

  @override
  Future<FBallReplyResDto> updateReView(FBallReplyUpdateReqDto fBallReplyUpdateReqDto) async {
    FBallReplyResDto fBallReplyResDto = await _fBallReplyUseCaseInputPort.updateFBallReply(fBallReplyUpdateReqDto);
    onAllUpdateSignal(fBallReplyResDto);
    return fBallReplyResDto;
  }

  onAllUpdateSignal(FBallReplyResDto fBallReplyResDto) {
    components.forEach((element) {
      element.onUpdated(fBallReplyResDto);
    });
  }

}