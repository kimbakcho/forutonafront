import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';

class MockFBallRepository extends Mock implements FBallRepository {}

void main() {
  setUp(() {

  });

  test('pass DTO ', () async {
    //arrange
    MockFBallRepository mockFBallRepository = MockFBallRepository();

    SelectBallUseCaseInputPort selectBallUseCase = SelectBallUseCase(
        fBallRepository: mockFBallRepository
    );

    String ballUuid = "TestBallUuid";

    var basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        ballUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TEST"));

    when(mockFBallRepository.selectBall(ballUuid)).thenAnswer((
        realInvocation) async =>basicFBallResDto );
    //act
    FBallResDto fBallResDto = await selectBallUseCase.selectBall(ballUuid);
    //assert
    expect(fBallResDto, basicFBallResDto);
  });
}