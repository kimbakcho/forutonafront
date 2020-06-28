import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingWrapDto.dart';

import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockTagRepository extends Mock implements TagRepository{}
class MockTagRankingFromBallInfluencePowerUseCaseOutputPort extends Mock implements TagRankingFromBallInfluencePowerUseCaseOutputPort{}
void main(){
  MockTagRepository mockTagRepository;
  MockTagRankingFromBallInfluencePowerUseCaseOutputPort mockTagRankingFromBallInfluencePowerUseCaseOutputPort;

  TagRankingFromBallInfluencePowerUseCaseInputPort tagRankingFromBallInfluencePowerUseCaseInputPort;

  setUp((){
    mockTagRepository = MockTagRepository();
    mockTagRankingFromBallInfluencePowerUseCaseOutputPort = MockTagRankingFromBallInfluencePowerUseCaseOutputPort();
    tagRankingFromBallInfluencePowerUseCaseInputPort  = TagRankingFromBallInfluencePowerUseCase(tagRepository: mockTagRepository);
    when(mockTagRepository.getFTagRankingFromBallInfluencePower(any))
        .thenAnswer((_) async => FBallTagRankingWrap.fromJson(json.decode(fixture('FTag/Data/DataSource/InfluenceTagRankingWrapDto.json'))));
  });

  test('레포지토리에 데이터 요청', () async {
    //arrange
    TagRankingFromBallInfluencePowerReqDto reqDto = new TagRankingFromBallInfluencePowerReqDto(position: Position(latitude: 127.0,longitude: 37.0),limit: 10);
    //act
    await tagRankingFromBallInfluencePowerUseCaseInputPort.reqTagRankingFromBallInfluencePower(reqDto, mockTagRankingFromBallInfluencePowerUseCaseOutputPort);
    //assert
    verify(mockTagRepository.getFTagRankingFromBallInfluencePower(any));
  });

  test('output에 데이터 전달', () async {
    //arrange
    TagRankingFromBallInfluencePowerReqDto reqDto = new TagRankingFromBallInfluencePowerReqDto(position: Position(latitude: 127.0,longitude: 37.0),limit: 10);
    //act
    await tagRankingFromBallInfluencePowerUseCaseInputPort.reqTagRankingFromBallInfluencePower(reqDto, mockTagRankingFromBallInfluencePowerUseCaseOutputPort);
    //assert
    verify(mockTagRepository.getFTagRankingFromBallInfluencePower(any));
    verify(mockTagRankingFromBallInfluencePowerUseCaseOutputPort.onTagRankingFromBallInfluencePower(any));
  });
}