import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:mockito/mockito.dart';

class MockRankingTagListFromBIListener extends Mock implements RankingTagListFromBIListener{}
void main(){

  RankingTagListFromBIManager rankingTagListFromBIManager;
  setUp((){
    rankingTagListFromBIManager = RankingTagListFromBIManager();
  });
  test('should 등록 테스트 ', () async {
    //arrange
    MockRankingTagListFromBIListener mockRankingTagListFromBIListener = MockRankingTagListFromBIListener();
    //act
    rankingTagListFromBIManager.subscribe(mockRankingTagListFromBIListener);
    //assert
    expect(rankingTagListFromBIManager.getSubscribeSize(), 1);
  });

  test('should 제거 테스트 ', () async {
    //arrange
    MockRankingTagListFromBIListener mockRankingTagListFromBIListener = MockRankingTagListFromBIListener();
    rankingTagListFromBIManager.subscribe(mockRankingTagListFromBIListener);
    //act
    rankingTagListFromBIManager.unSubscribe(mockRankingTagListFromBIListener);
    //assert
    expect(rankingTagListFromBIManager.getSubscribeSize(), 0);
  });

  test('should search 명령어 테스트 ', () async {
    //arrange
    MockRankingTagListFromBIListener mockRankingTagListFromBIListener = MockRankingTagListFromBIListener();
    rankingTagListFromBIManager.subscribe(mockRankingTagListFromBIListener);
    Position position = Position(latitude: 37.1,longitude: 127.1);
    //act
    rankingTagListFromBIManager.search(position);
    //assert
    verify(mockRankingTagListFromBIListener.search(position));
  });
}