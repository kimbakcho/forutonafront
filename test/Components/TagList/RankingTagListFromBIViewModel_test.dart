import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBI.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockGeoLocationUtilBasicUseCaseInputPort extends Mock
    implements GeoLocationUtilBasicUseCaseInputPort {}

class MockTagRepository extends Mock implements TagRepository {}

void main() {
  RankingTagListFromBIViewModel rankingTagListFromBIViewModel;
  RankingTagListFromBIManager rankingTagListFromBIManager;
  MockGeoLocationUtilBasicUseCaseInputPort
      mockGeoLocationUtilBasicUseCaseInputPort;
  MockTagRepository mockTagRepository;
  TagRankingFromBallInfluencePowerUseCaseInputPort
      tagRankingFromBallInfluencePowerUseCaseInputPort;

  setUp(() {
    rankingTagListFromBIManager = RankingTagListFromBIManager();
    mockTagRepository = MockTagRepository();
    mockGeoLocationUtilBasicUseCaseInputPort =
        MockGeoLocationUtilBasicUseCaseInputPort();
    tagRankingFromBallInfluencePowerUseCaseInputPort =
        TagRankingFromBallInfluencePowerUseCase(
            tagRepository: mockTagRepository);

    rankingTagListFromBIViewModel = RankingTagListFromBIViewModel(
        rankingTagListFromBIManager: rankingTagListFromBIManager,
        geoLocationUtilBasicUseCaseInputPort:
            mockGeoLocationUtilBasicUseCaseInputPort,
        tagRankingFromBallInfluencePowerUseCaseInputPort:
            tagRankingFromBallInfluencePowerUseCaseInputPort);
  });

  test('생성시 등록 테스트 ', () async {
    //arrange

    //act

    //assert
    equals(rankingTagListFromBIManager.getSubscribeSize(), 1);
  });

  test('should 해제시 제거 테스트 ', () async {
    //arrange

    //act
    rankingTagListFromBIViewModel.dispose();
    //assert
    equals(rankingTagListFromBIManager.getSubscribeSize(), 0);
  });

  test('should 서치 테스트 ', () async {
    //arrange
    when(mockGeoLocationUtilBasicUseCaseInputPort.getCurrentWithLastPosition())
        .thenAnswer((realInvocation) async =>
            Position(latitude: 37.1, longitude: 127.1));

    var decode = (json.decode(fixtureString(
            "FTag/Data/DataSource/InfluenceTagRankingWrapDto.json")) as List)
        .map((e) => TagRankingResDto.fromJson(e))
        .toList();

    when(mockTagRepository.getFTagRankingFromBallInfluencePower(any))
        .thenAnswer((realInvocation) async => decode);

    Position searchPosition = Position(latitude: 37.1, longitude: 127.1);
    //act
    await rankingTagListFromBIViewModel.search(searchPosition);
    //assert
    equals(rankingTagListFromBIViewModel.tagRankingResDtos.length, 3);
  });
}
