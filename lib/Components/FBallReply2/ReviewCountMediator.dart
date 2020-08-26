

import 'package:forutonafront/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';

abstract class ReviewCountMediatorComponent {
  onReviewCount(int reviewCount);

}

abstract class ReviewCountMediator {
  registerComponent(ReviewCountMediatorComponent reviewInertMediatorComponent);

  unregisterComponent(
      ReviewCountMediatorComponent reviewCountMediatorComponent);
  int componentCount();
  Future<int> reqReviewCount(String ballUuid);

  int reviewCount;
}

class ReviewCountMediatorImpl implements ReviewCountMediator{
  int reviewCount = 0;

  List<ReviewCountMediatorComponent> components = [];

  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;

  ReviewCountMediatorImpl({FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort;

  @override
  registerComponent(ReviewCountMediatorComponent reviewCountMediatorComponent) {
    components.add(reviewCountMediatorComponent);
  }

  @override
  Future<int> reqReviewCount(String ballUuid) async {
    int reviewCount = await _fBallReplyUseCaseInputPort.getBallReviewCount(ballUuid);
    this.reviewCount = reviewCount;
    onAllReviewCount(reviewCount);
    return reviewCount;
  }

  onAllReviewCount(int reviewCount) {
    components.forEach((element) {
      element.onReviewCount(reviewCount);
    });
  }

  @override
  unregisterComponent(ReviewCountMediatorComponent reviewCountMediatorComponent) {
    components.remove(reviewCountMediatorComponent);
  }

  @override
  int componentCount() {
    return components.length;
  }


}
