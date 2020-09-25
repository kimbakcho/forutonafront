import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:mockito/mockito.dart';

class MockTagRepository extends Mock implements TagRepository {}

void main() {
  MockTagRepository mockTagRepository;
  TagRankingUseCaseInputPort tagRankingFromBallInfluencePowerUseCase;
  TagRankingFromBallInfluencePowerReqDto reqDto;
  setUp(() {
    mockTagRepository = MockTagRepository();

    reqDto = TagRankingFromBallInfluencePowerReqDto(
      mapCenterLatitude: 37.5012,
      mapCenterLongitude: 126.8976,
    );

    tagRankingFromBallInfluencePowerUseCase =
        TagRankingFromBallInfluencePowerUseCase(
            tagRepository: mockTagRepository, reqDto: reqDto);
  });
  test('reqTagRankingFromBallInfluencePower 실행 테스트', () async {
    //arrange

    //act
    await tagRankingFromBallInfluencePowerUseCase.search();
    //assert
    verify(mockTagRepository.getFTagRankingFromBallInfluencePower(reqDto));
  });
}
