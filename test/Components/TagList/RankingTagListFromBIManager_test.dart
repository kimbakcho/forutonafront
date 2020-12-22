import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagRankingUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

class MockRankingTagListMediatorComponent extends Mock implements SearchCollectMediatorComponent{}
class MockTagRankingUseCaseInputPort extends Mock implements TagRankingUseCaseInputPort{}
void main(){

  RankingTagListMediator rankingTagListFromBIManager;
  setUp((){
    rankingTagListFromBIManager = RankingTagListMediatorImpl();
  });
  test('should 등록 테스트 ', () async {
    //arrange
    MockRankingTagListMediatorComponent mockRankingTagListMediatorComponent = MockRankingTagListMediatorComponent();
    //act
    rankingTagListFromBIManager.registerComponent(mockRankingTagListMediatorComponent);
    //assert
    expect(rankingTagListFromBIManager.componentSize(), 1);
  });

  test('should 제거 테스트 ', () async {
    //arrange
    MockRankingTagListMediatorComponent mockRankingTagListMediatorComponent = MockRankingTagListMediatorComponent();
    rankingTagListFromBIManager.registerComponent(mockRankingTagListMediatorComponent);
    //act
    rankingTagListFromBIManager.unregisterComponent(mockRankingTagListMediatorComponent);
    //assert
    expect(rankingTagListFromBIManager.componentSize(), 0);
  });

  test('should search 명령어 테스트 ', () async {
    //arrange
    MockRankingTagListMediatorComponent mockRankingTagListMediatorComponent = MockRankingTagListMediatorComponent();
    MockTagRankingUseCaseInputPort mockTagRankingUseCaseInputPort = MockTagRankingUseCaseInputPort();
    rankingTagListFromBIManager.registerComponent(mockRankingTagListMediatorComponent);
    // Position position = Position(latitude: 37.1,longitude: 127.1);
    rankingTagListFromBIManager.tagRankingUseCaseInputPort = mockTagRankingUseCaseInputPort;
    //act
    await rankingTagListFromBIManager.searchFirst();
    //assert
    verify(mockRankingTagListMediatorComponent.onItemListUpUpdate());
  });

}