import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class ReviewInertMediatorComponent {
  onInserted(FBallReplyResDto fBallReplyResDto);

}

abstract class ReviewInertMediator {
  registerComponent(ReviewInertMediatorComponent reviewInertMediatorComponent);
  Future<FBallReplyResDto> insertReview(FBallReplyInsertReqDto reqDto);
}

class ReviewInertMediatorImpl implements ReviewInertMediator {

  List<ReviewInertMediatorComponent> components = [];

  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;

  ReviewInertMediatorImpl(
      {FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      :_fBallReplyUseCaseInputPort=fBallReplyUseCaseInputPort;

  @override
  registerComponent(ReviewInertMediatorComponent reviewInertMediatorComponent) {
    components.add(reviewInertMediatorComponent);
  }

  onAllInserted(FBallReplyResDto fBallReplyResDto) {
    components.forEach((element) {
      element.onInserted(fBallReplyResDto);
    });
  }

  @override
  Future<FBallReplyResDto> insertReview(FBallReplyInsertReqDto reqDto) async {
    FBallReplyResDto resDto =
        await _fBallReplyUseCaseInputPort.insertFBallReply(reqDto);
    onAllInserted(resDto);
    return resDto;
  }


}