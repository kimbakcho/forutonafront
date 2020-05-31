
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:mockito/mockito.dart';

class MockFBallUseCaseInputPort extends Mock implements
    FBallUseCaseInputPort{}

void main(){
  MockFBallUseCaseInputPort mockFBallUseCaseInputPort;
  setUp((){
    mockFBallUseCaseInputPort = MockFBallUseCaseInputPort();
  });
  final FBallListUpWrapDto fBallListUpWrapDto = FBallListUpWrapDto(searchTime: DateTime.now(),balls: []);
  final fBallListUpReqDto = FBallListUpReqDto(
      longitude: 124.5,
      latitude: 55.5,
      size: 10,
      ballLimit: 20,
      page: 1,
      sort: "WriteTime,Desc"
  );
  test('should be Position Serach Listup',
          () async {
      //arrange
            when(mockFBallUseCaseInputPort.positionSearchListUpBall(searchReqDto: fBallListUpReqDto))
                .thenAnswer((_) async => fBallListUpWrapDto);
      //act
            var positionSearchListUpBall = await mockFBallUseCaseInputPort.positionSearchListUpBall(searchReqDto: fBallListUpReqDto);
      //assert
            expect(positionSearchListUpBall, fBallListUpWrapDto);

  });


}