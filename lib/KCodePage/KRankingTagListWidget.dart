import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagList.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromTextOrderBySumBIUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromTextReqDto.dart';
import 'package:provider/provider.dart';

class KRankingTagListWidget extends StatelessWidget {
  final String searchText;

  const KRankingTagListWidget({Key key, @required this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KRankingTagListWidgetViewModel(
            searchText: searchText,
            rankingTagListMediator: sl(),
            geoLocationUtilForeGroundUseCaseInputPort: sl()),
        child:
            Consumer<KRankingTagListWidgetViewModel>(builder: (_, model, __) {
          return model.hasTagRankingItem()
              ? RankingTagList(
                  rankingTagListMediator: model.rankingTagListMediator)
              : Container();
        }));
  }
}

class KRankingTagListWidgetViewModel extends ChangeNotifier {
  final RankingTagListMediator rankingTagListMediator;
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;
  final String searchText;

  KRankingTagListWidgetViewModel(
      {@required this.searchText,
      @required this.rankingTagListMediator,
      @required this.geoLocationUtilForeGroundUseCaseInputPort}) {
    init();
  }

  void init() async {
    TagRankingFromTextReqDto tagRankingFromTextReqDto =
        new TagRankingFromTextReqDto();
    var position = await geoLocationUtilForeGroundUseCaseInputPort
        .getCurrentWithLastPosition();

    tagRankingFromTextReqDto.mapCenterLatitude = position.latitude;
    tagRankingFromTextReqDto.mapCenterLongitude = position.longitude;
    tagRankingFromTextReqDto.searchTagText = searchText;

    this.rankingTagListMediator.tagRankingUseCaseInputPort =
        TagRankingFromTextOrderBySumBIUseCase(
            reqDto: tagRankingFromTextReqDto, tagRepository: sl());

    await this.rankingTagListMediator.searchFirst();

    notifyListeners();
  }

  bool hasTagRankingItem() {
    if (this.rankingTagListMediator.itemList.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
