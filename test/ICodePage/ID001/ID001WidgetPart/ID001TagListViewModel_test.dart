import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001TagList.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:mockito/mockito.dart';

import '../../../TestUtil/FBall/FBallTestUtil.dart';
import '../../../TestUtil/FUserInfoSimple/FUserInfoSimpleTestUtil.dart';
import '../../../TestUtil/Tag/TagTestUtil.dart';

class MockTagRepository extends Mock implements TagRepository{}
void main (){
  ID001TagListViewModel id001tagListViewModel;
  setUp((){
    di.init();
    sl.allowReassignment = true;
  });

  test('태그를 Infrastruct 에서 가져오는지 테스트', () async {
    //arrange
    String testBallUuid = "TestBallUuid";
    MockTagRepository mockTagRepository = new MockTagRepository();
    sl.registerSingleton<TagRepository>(mockTagRepository);
    List<FBallTagResDto> tags = [];
    FBallResDto basicFBallResDto = FBallTestUtil.getBasicFBallResDto(testBallUuid,
        FUserInfoSimpleTestUtil.getBasicUserResDto("TESTUid"));

    tags.add(TagTestUtil.makeBasicTagResDto("test1", basicFBallResDto));
    tags.add(TagTestUtil.makeBasicTagResDto("test2", basicFBallResDto));
    tags.add(TagTestUtil.makeBasicTagResDto("test3", basicFBallResDto));

    when(mockTagRepository.tagFromBallUuid(any)).thenAnswer((realInvocation) async => tags);
    sl.registerSingleton<TagFromBallUuidUseCaseInputPort>(TagFromBallUuidUseCase(
      tagRepository: sl()
    ));

    id001tagListViewModel = ID001TagListViewModel(
      ballUuid: testBallUuid,
      tagFromBallUuidUseCaseInputPort: sl()
    );
    //act
    await id001tagListViewModel.init();
    //assert
    expect(id001tagListViewModel.ballTags.length, 3);

  });
}