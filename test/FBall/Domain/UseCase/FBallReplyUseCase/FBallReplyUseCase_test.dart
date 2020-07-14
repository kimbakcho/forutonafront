import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';
import 'package:mockito/mockito.dart';

class MockFBallReplyRepository extends Mock implements FBallReplyRepository {}
class MockFBallReplyUseCaseOutputPort extends Mock implements FBallReplyUseCaseOutputPort{}
void main() {
  FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort;
  MockFBallReplyRepository mockFBallReplyRepository;
  MockFBallReplyUseCaseOutputPort mockFBallReplyUseCaseOutputPort;
  setUp(() {
    mockFBallReplyUseCaseOutputPort = MockFBallReplyUseCaseOutputPort();
    mockFBallReplyRepository = MockFBallReplyRepository();
    fBallReplyUseCaseInputPort =
        FBallReplyUseCase(fBallReplyRepository: mockFBallReplyRepository);
  });

  test('should deleteFBallReply Repository call', () async {
    //arrange
    String replyUuid = "replyUuid";
    //act
    await fBallReplyUseCaseInputPort.deleteFBallReply(replyUuid);
    //assert
    verify(mockFBallReplyRepository.deleteFBallReply(replyUuid));
  });

  test('should getFBallReply Repository call', () async {
    //arrange
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = "testBallUUid";
    FBallReplyResWrap fBallReplyResWrap = FBallReplyResWrap();
    fBallReplyResWrap.count = 0;
    fBallReplyResWrap.replyTotalCount = 0;
    fBallReplyResWrap.contents = [];
    when(mockFBallReplyRepository.getFBallReply(reqDto))
        .thenAnswer((realInvocation) async => fBallReplyResWrap);
    //act
    await fBallReplyUseCaseInputPort.reqFBallReply(reqDto,outputPort: mockFBallReplyUseCaseOutputPort);
    //assert
    verify(mockFBallReplyUseCaseOutputPort.onFBallReply(any));
    verify(mockFBallReplyUseCaseOutputPort.onFBallReplyTotalCount(any));
    verify(mockFBallReplyRepository.getFBallReply(reqDto));
  });

  test('should insertFBallReply Repository call', () async {
    //arrange
    FBallReplyInsertReqDto reqDto  = FBallReplyInsertReqDto();
    reqDto.ballUuid = "testBallUUid";
    FBallReply fBallReply = FBallReply();
    fBallReply.ballUuid = "testBallUUid";

    when(mockFBallReplyRepository.insertFBallReply(reqDto))
        .thenAnswer((realInvocation) async => fBallReply);
    //act
    await fBallReplyUseCaseInputPort.insertFBallReply(reqDto);
    //assert
    verify(mockFBallReplyRepository.insertFBallReply(reqDto));
  });

  test('should updateFBallReply Repository call', () async {
    //arrange
    FBallReplyUpdateReqDto reqDto  = FBallReplyUpdateReqDto();
    reqDto.replyUuid = "testBallUUid";
    FBallReply fBallReply = FBallReply();
    fBallReply.ballUuid = "testBallUUid";
    when(mockFBallReplyRepository.updateFBallReply(reqDto))
        .thenAnswer((realInvocation) async => fBallReply);
    //act
    await fBallReplyUseCaseInputPort.updateFBallReply(reqDto);
    //assert
    verify(mockFBallReplyRepository.updateFBallReply(reqDto));
  });
}
