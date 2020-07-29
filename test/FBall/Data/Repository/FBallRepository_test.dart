import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockIFBallRemoteDataSource extends Mock implements FBallRemoteDataSource {}
void main() {

  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  MockIFBallRemoteDataSource mockIFBallRemoteDataSource;
  FBallRepository fBallRepository;


  final FBallListUpFromBallInfluencePowerReqDto searchCondition =
      new FBallListUpFromBallInfluencePowerReqDto(
    latitude: 37.43469925835876,
    longitude: 126.79077610373497,
    ballLimit: 1000,
    page: 0,
    size: 20,
  );

  setUp(() {
//    mockIFBallRemoteDataSource = MockIFBallRemoteDataSource();
//    fBallRepository =
//        FBallRepositoryImpl(fBallRemoteDataSource: mockIFBallRemoteDataSource);
//    when(mockIFBallRemoteDataSource.listUpFromInfluencePower(any, any))
//        .thenAnswer((_) async => FBallListUpWrap.fromJson(json.decode(
//        fixtureString('FBall/Data/DataSource/BallListUpPositionWrapDto.json'))));
  });

  test('영향력순 으로 Ball ListUp DataSource Call ', () async {
    //arrange

    //act
    var result = await fBallRepository.listUpFromInfluencePower(listUpReqDto: searchCondition);
    //assert
    verify(mockIFBallRemoteDataSource.listUpFromInfluencePower(any,any));

    expect(result, TypeMatcher<FBallListUpWrap>());
  });


}
