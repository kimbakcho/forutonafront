import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagChip.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:provider/provider.dart';

import 'RankingTagListMediator.dart';

class RankingTagListFromBI extends StatefulWidget {
  final RankingTagListMediator rankingTagListMediator;

  const RankingTagListFromBI({Key key, this.rankingTagListMediator})
      : super(key: key);

  @override
  _RankingTagListFromBIState createState() => _RankingTagListFromBIState();
}

class _RankingTagListFromBIState extends State<RankingTagListFromBI>
    with AutomaticKeepAliveClientMixin<RankingTagListFromBI> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RankingTagListFromBIViewModel(
            rankingTagListMediator: widget.rankingTagListMediator),
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

  @override
  bool get wantKeepAlive => true;
}

class RankingTagListFromBIViewModel extends ChangeNotifier
    implements
        RankingTagListMediatorComponent {
  final RankingTagListMediator rankingTagListMediator;

  RankingTagListFromBIViewModel(
      {@required this.rankingTagListMediator}) {
    if (rankingTagListMediator != null) {
      rankingTagListMediator.registerComponent(this);
    }
  }

  @override
  void dispose() {
    if (rankingTagListMediator != null) {
      rankingTagListMediator.unregisterComponent(this);
    }
    super.dispose();
  }

  List<TagRankingResDto>  get tagRankingResDtos {
    return rankingTagListMediator.tagRankingResDtos;
  }


  @override
  Future<void> onTagListUpdate() async{
    notifyListeners();
  }
}
