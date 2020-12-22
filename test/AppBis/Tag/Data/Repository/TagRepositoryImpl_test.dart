import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/AppBis/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/AppBis/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockFBallTagRemoteDataSource extends Mock
    implements FBallTagRemoteDataSource {}

void main() {
  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  MockFBallTagRemoteDataSource mockFBallTagRemoteDataSource;
  TagRepository tagRepository;
  setUp(() {
    mockFBallTagRemoteDataSource = MockFBallTagRemoteDataSource();
    tagRepository = TagRepositoryImpl(
        fBallTagRemoteDataSource: mockFBallTagRemoteDataSource);
  });

  test('Tag 영향력 DataSource Req', () async {
    //arrange
    TagRankingFromBallInfluencePowerReqDto reqDto =
        TagRankingFromBallInfluencePowerReqDto(
      mapCenterLatitude: 37.5012,
      mapCenterLongitude: 126.8976,
    );
    //act
    tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    //assert
    verify(mockFBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(
        any, any));
  });
}
