import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:mockito/mockito.dart';

class MockTagRepository extends Mock implements TagRepository {}

class MockTagRankingFromBallInfluencePowerUseCaseOutputPort extends Mock
    implements TagRankingFromBallInfluencePowerUseCaseOutputPort {}

void main() {
  MockTagRepository mockTagRepository;
  TagRankingFromBallInfluencePowerUseCaseInputPort
      tagRankingFromBallInfluencePowerUseCaseInputPort;
  MockTagRankingFromBallInfluencePowerUseCaseOutputPort
      tagRankingFromBallInfluencePowerUseCaseOutputPort;
  setUp(() {
    mockTagRepository = MockTagRepository();

    tagRankingFromBallInfluencePowerUseCaseInputPort =
        TagRankingFromBallInfluencePowerUseCase(
            tagRepository: mockTagRepository);
  });
  test('reqTagRankingFromBallInfluencePower 실행 테스트', () async {
    //arrange
    tagRankingFromBallInfluencePowerUseCaseOutputPort =
        MockTagRankingFromBallInfluencePowerUseCaseOutputPort();
    TagRankingFromBallInfluencePowerReqDto reqDto =
        TagRankingFromBallInfluencePowerReqDto(
      userLatitude: 37.5012,
      userLongitude: 126.9203,
      mapCenterLatitude: 37.5012,
      mapCenterLongitude: 126.8976,
    );
    //act
    await tagRankingFromBallInfluencePowerUseCaseInputPort
        .reqTagRankingFromBallInfluencePower(reqDto, tagRankingFromBallInfluencePowerUseCaseOutputPort);
    //assert
    verify(mockTagRepository.getFTagRankingFromBallInfluencePower(reqDto));
    verify(tagRankingFromBallInfluencePowerUseCaseOutputPort.onTagRankingFromBallInfluencePower(any));
  });
}
