import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TagList/RankingTagChip.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:provider/provider.dart';
import 'RankingTagListMediator.dart';

class RankingTagList extends StatefulWidget {
  final RankingTagListMediator rankingTagListMediator;

  const RankingTagList({Key key, this.rankingTagListMediator})
      : super(key: key);

  @override
  _RankingTagListState createState() => _RankingTagListState();
}

class _RankingTagListState extends State<RankingTagList>
    with AutomaticKeepAliveClientMixin<RankingTagList> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RankingTagListViewModel(
            rankingTagListMediator: widget.rankingTagListMediator),
        child: Consumer<RankingTagListViewModel>(builder: (_, model, __) {
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

class RankingTagListViewModel extends ChangeNotifier
    implements
        RankingTagListMediatorComponent {
  final RankingTagListMediator rankingTagListMediator;

  RankingTagListViewModel(
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
