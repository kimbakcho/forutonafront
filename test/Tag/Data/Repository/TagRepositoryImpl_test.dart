import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';

class MockFBallTagRemoteDataSource extends Mock implements FBallTagRemoteDataSource{}
void main(){

  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  MockFBallTagRemoteDataSource mockFBallTagRemoteDataSource;
  TagRepository tagRepository;
  setUp((){
    mockFBallTagRemoteDataSource = MockFBallTagRemoteDataSource();
    tagRepository = TagRepositoryImpl(fBallTagRemoteDataSource: mockFBallTagRemoteDataSource);
  });

  test('Tag 영향력 DataSource Req', () async {
    //arrange
    TagRankingFromBallInfluencePowerReqDto reqDto = TagRankingFromBallInfluencePowerReqDto(
      latitude: 37.0,
      longitude: 127.0,
      limit: 10
    );
    //act
    tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    //assert
    verify(mockFBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(any,any));
  });
}