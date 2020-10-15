
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagList.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:mockito/mockito.dart';



class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

class MockTagRepository extends Mock implements TagRepository {}

void main() {
  RankingTagListViewModel rankingTagListFromBIViewModel;

  RankingTagListMediator rankingTagListMediator;




  setUp(() {
    rankingTagListMediator = RankingTagListMediatorImpl();



    rankingTagListFromBIViewModel = RankingTagListViewModel(
        rankingTagListMediator: rankingTagListMediator
    );
  });

  test('생성시 등록 테스트 ', () async {
    //arrange

    //act

    //assert
    equals(rankingTagListMediator.componentSize(), 1);
  });

  test('should 해제시 제거 테스트 ', () async {
    //arrange

    //act
    rankingTagListFromBIViewModel.dispose();
    //assert
    equals(rankingTagListMediator.componentSize(), 0);
  });

}
