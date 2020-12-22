import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001TagList.dart';
import 'package:forutonafront/AppBis/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../../TestUtil/Tag/TagTestUtil.dart';

class MockTagRepository extends Mock implements TagRepository {}

class MockTagFromBallUuidUseCaseInputPort extends Mock
    implements TagFromBallUuidUseCaseInputPort {}

void main() {
  ID001TagListViewModel id001tagListViewModel;
  MockTagFromBallUuidUseCaseInputPort mockTagFromBallUuidUseCaseInputPort;
  setUp(() {
    mockTagFromBallUuidUseCaseInputPort = MockTagFromBallUuidUseCaseInputPort();
  });

  test('태그를 Infrastruct 에서 가져오는지 테스트', () async {
    //arrange
    String testBallUuid = "TestBallUuid";

    List<FBallTagResDto> tags = [];
    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(
        testBallUuid, FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid"));

    tags.add(TagTestUtil.makeBasicTagResDto("test1", basicFBallResDto));
    tags.add(TagTestUtil.makeBasicTagResDto("test2", basicFBallResDto));
    tags.add(TagTestUtil.makeBasicTagResDto("test3", basicFBallResDto));

    when(mockTagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
            ballUuid: anyNamed('ballUuid'), outputPort: anyNamed('outputPort')))
        .thenAnswer((realInvocation) async => tags);

    id001tagListViewModel = ID001TagListViewModel(
        ballUuid: testBallUuid,
        tagFromBallUuidUseCaseInputPort: mockTagFromBallUuidUseCaseInputPort);
    //act
    await id001tagListViewModel.init();
    //assert
    verify(mockTagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: testBallUuid, outputPort: anyNamed('outputPort')));
  });
}
