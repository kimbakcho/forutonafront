import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagChip.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:provider/provider.dart';

import 'RankingTagListFromBIManager.dart';

class RankingTagListFromBI extends StatelessWidget {
  final RankingTagListFromBIManager rankingTagListFromBIManager;

  RankingTagListFromBI({this.rankingTagListFromBIManager});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RankingTagListFromBIViewModel(
            geoLocationUtilBasicUseCaseInputPort: sl(),
            tagRankingFromBallInfluencePowerUseCaseInputPort: sl(),
            rankingTagListFromBIManager: rankingTagListFromBIManager),
        child: Consumer<RankingTagListFromBIViewModel>(builder: (_, model, __) {
          return Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
              height: 30,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 16),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: model.tagRankingResDtos.length,
                  itemBuilder: (_, index) {
                    return RankingTagChip(
                        key: UniqueKey(),
                        tagName: model.tagRankingResDtos[index].tagName);
                  }));
        }));
  }
}

class RankingTagListFromBIViewModel extends ChangeNotifier
    implements
        RankingTagListFromBIListener,
        TagRankingFromBallInfluencePowerUseCaseOutputPort {
  RankingTagListFromBIManager rankingTagListFromBIManager;
  GeoLocationUtilBasicUseCaseInputPort _geoLocationUtilBasicUseCaseInputPort;
  List<TagRankingResDto> tagRankingResDtos = [];
  TagRankingFromBallInfluencePowerUseCaseInputPort
      _tagRankingFromBallInfluencePowerUseCaseInputPort;

  RankingTagListFromBIViewModel(
      {this.rankingTagListFromBIManager,
      GeoLocationUtilBasicUseCaseInputPort geoLocationUtilBasicUseCaseInputPort,
      TagRankingFromBallInfluencePowerUseCaseInputPort
          tagRankingFromBallInfluencePowerUseCaseInputPort})
      : _geoLocationUtilBasicUseCaseInputPort =
            geoLocationUtilBasicUseCaseInputPort,
        _tagRankingFromBallInfluencePowerUseCaseInputPort =
            tagRankingFromBallInfluencePowerUseCaseInputPort {
    if (rankingTagListFromBIManager != null) {
      rankingTagListFromBIManager.subscribe(this);
    }
  }

  @override
  void dispose() {
    if (rankingTagListFromBIManager != null) {
      rankingTagListFromBIManager.unSubscribe(this);
    }
    super.dispose();
  }

  @override
  search(Position searchPosition) async {
    var userPosition = await _geoLocationUtilBasicUseCaseInputPort
        .getCurrentWithLastPosition();
    TagRankingFromBallInfluencePowerReqDto reqDto =
        TagRankingFromBallInfluencePowerReqDto(
            userLatitude: userPosition.latitude,
            userLongitude: userPosition.longitude,
            mapCenterLatitude: searchPosition.latitude,
            mapCenterLongitude: searchPosition.longitude);
    await _tagRankingFromBallInfluencePowerUseCaseInputPort
        .reqTagRankingFromBallInfluencePower(reqDto, this);
  }

  @override
  void onTagRankingFromBallInfluencePower(
      List<TagRankingResDto> tagRankingDtos) {
    this.tagRankingResDtos = tagRankingDtos;
    notifyListeners();
  }
}
