import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:mockito/mockito.dart';


class MockBallListMediator extends Mock implements BallListMediator {}

class MockRankingTagListFromBIManager extends Mock
    implements RankingTagListMediatorImpl {}

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

class MockFBallRepository extends Mock implements FBallRepository {}

class MockNoInterestBallUseCaseInputPort extends Mock implements NoInterestBallUseCaseInputPort{}

void main() {
  H001ViewModel h001viewModel;
  MockBallListMediator mockBallListMediator;
  MockRankingTagListFromBIManager mockRankingTagListFromBIManager;
  MockGeoLocationUtilBasicUseCaseInputPort
  mockGeoLocationUtilBasicUseCaseInputPort;

  MockFBallRepository mockFBallRepository;

  setUp(() {
    mockFBallRepository = MockFBallRepository();
    mockGeoLocationUtilBasicUseCaseInputPort =
        MockGeoLocationUtilBasicUseCaseInputPort();
    mockBallListMediator = MockBallListMediator();
    mockRankingTagListFromBIManager = MockRankingTagListFromBIManager();
    h001viewModel = H001ViewModel(
        ballListMediator: mockBallListMediator,
        noInterestBallUseCaseInputPort: MockNoInterestBallUseCaseInputPort(),
        h001manager: H001Manager(),
        geoLocationUtilBasicUseCaseInputPort: mockGeoLocationUtilBasicUseCaseInputPort,
        fBallRepository: mockFBallRepository,
        rankingTagListFromBIManager: mockRankingTagListFromBIManager);
  });

  test('should search 행위 테스트', () async {
    //given
    Position mapPosition = Position(latitude: 37.1, longitude: 127.1);
    when(mockGeoLocationUtilBasicUseCaseInputPort.getCurrentWithLastPosition())
        .thenAnswer((realInvocation) async =>
        Position(latitude: 37.2, longitude: 127.2));
    //when
    await h001viewModel.search(mapPosition);
    //then
    verify(mockBallListMediator.searchFirst());
    verify(mockRankingTagListFromBIManager.search(mapPosition));
  });
}
