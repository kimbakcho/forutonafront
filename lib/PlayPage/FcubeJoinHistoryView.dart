import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FcubeplayerExtender2.dart';
import 'package:forutonafront/Common/FcubeplayerSearch.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/globals.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class FcubeJoinHistoryView extends StatefulWidget {
  FcubeJoinHistoryView({Key key}) : super(key: key);

  @override
  _FcubeJoinHistoryViewState createState() => _FcubeJoinHistoryViewState();
}

class _FcubeJoinHistoryViewState extends State<FcubeJoinHistoryView>
    with AfterInitMixin<FcubeJoinHistoryView> {
  ScrollController scrollController = ScrollController();
  int pageoffset = 0;
  int pagelimit = 10;
  bool isloading = false;
  List<FcubeplayerExtender2> joinlist = List<FcubeplayerExtender2>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() async {
      //bottom 에 닿을때
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        setState(() {});
      }
    });
  }

  @override
  void didInitState() async {
    isloading = true;
    setState(() {});
    FcubeplayerSearch searchitem = FcubeplayerSearch(
        uid: GlobalStateContainer.of(context).state.userInfoMain.uid,
        limit: pagelimit,
        offset: pageoffset);
    joinlist = await FcubeplayerExtender2.getPlayerJoinList(searchitem);
    isloading = false;
    setState(() {});
  }

  selectCubetypetoPage(FcubeplayerExtender2 item) async {
    if (item.cubetype == FcubeType.questCube) {
      FcubeExtender1 fcubeExtender1 = await FcubeExtender1.getFcubeExtender1(
          GlobalStateContainer.of(context).state.userInfoMain.uid,
          item.cubeuuid);
      await Navigator.push(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "FcubeQuestDetailPage"),
              builder: (context) {
                return FcubeQuestDetailPage(fcubeextender1: fcubeExtender1);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: isloading
          ? Container(
              color: Colors.lightBlue,
              child: Center(
                child: Loading(
                    indicator: BallScaleIndicator(),
                    size: 50.0,
                    color: Colors.pink),
              ),
            )
          : Container(
              child: ListView.builder(
                controller: scrollController,
                itemCount: joinlist.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      color: Colors.grey,
                      child: FlatButton(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text("${joinlist[index].cubename}"),
                            )
                          ],
                        ),
                        onPressed: () {
                          selectCubetypetoPage(joinlist[index]);
                        },
                      ));
                },
              ),
            ),
    );
  }
}
