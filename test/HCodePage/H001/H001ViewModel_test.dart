import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:mockito/mockito.dart';

class MockH001Manager extends Mock implements H001Manager {}

class MockBallListMediator extends Mock implements BallListMediator {}

class MockRankingTagListFromBIManager extends Mock
    implements RankingTagListFromBIManager {}

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

void main() {
  H001ViewModel h001viewModel;
  MockBallListMediator mockBallListMediator;
  MockRankingTagListFromBIManager mockRankingTagListFromBIManager;
  MockGeoLocationUtilBasicUseCaseInputPort
      mockGeoLocationUtilBasicUseCaseInputPort;
  MockH001Manager mockH001Manager;
  setUp(() {
    di.init();
    sl.allowReassignment = true;
    mockH001Manager = MockH001Manager();
    mockGeoLocationUtilBasicUseCaseInputPort =
        MockGeoLocationUtilBasicUseCaseInputPort();
    sl.registerSingleton<H001Manager>(mockH001Manager);
    sl.registerSingleton<GeoLocationUtilBasicUseCaseInputPort>(
        mockGeoLocationUtilBasicUseCaseInputPort);
    mockBallListMediator = MockBallListMediator();
    mockRankingTagListFromBIManager = MockRankingTagListFromBIManager();
    h001viewModel = H001ViewModel(
        ballListMediator: mockBallListMediator,
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
