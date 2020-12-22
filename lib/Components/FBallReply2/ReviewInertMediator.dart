
import 'package:forutonafront/AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:injectable/injectable.dart';

abstract class ReviewInertMediatorComponent {
  onInserted(FBallReplyResDto fBallReplyResDto);

}

abstract class ReviewInertMediator {
  registerComponent(ReviewInertMediatorComponent reviewInertMediatorComponent);
  unregisterComponent(ReviewInertMediatorComponent reviewInertMediatorComponent);
  int componentCount();
  Future<FBallReplyResDto> insertReview(FBallReplyInsertReqDto reqDto);
}
@Injectable(as: ReviewInertMediator)
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

  @override
  unregisterComponent(ReviewInertMediatorComponent reviewInertMediatorComponent) {
    components.remove(reviewInertMediatorComponent);
  }

  @override
  int componentCount() {
    return components.length;
  }




}