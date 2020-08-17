import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class H001Page extends StatelessWidget {
  final BallListMediator _influencePowerBallListMediator;

  H001Page({BallListMediator influencePowerBallListMediator})
      : _influencePowerBallListMediator = influencePowerBallListMediator;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H001ViewModel(
            context: context,
            fireBaseAuthAdapterForUseCase: sl(),
            geoLocationUtilUseCaseInputPort: sl(),
            influencePowerBallListMediator: _influencePowerBallListMediator,
            tagRankingFromPositionUseCaseInputPort: sl()),
        child: Consumer<H001ViewModel>(builder: (_, model, __) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    child: Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (_, index) {
                                return Container(
                                    key: Key(model.ballList[index].ballUuid),
                                    child: FlatButton(
                                      onPressed: (){
                                        model.moveDetailPage(index);
                                      },
                                        child: Text(
                                      model.ballList[index].ballUuid,
                                    )));
                              },
                              itemCount: model.ballList.length,
                            ),
                          )
                        ],
                      ),
                      model.isLoading ? CommonLoadingComponent() : Container()
                    ])))
          ]);
        }));
  }

  Container ballEmptyPanel() {
    return Container(
        child: Center(
            child: Text("아쉽지만\n검색하신 지역에 컨텐츠가 없습니다.",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14,
                  color: Color(0xffb1b1b1),
                ),
                textAlign: TextAlign.center)));
  }

  ListView buildListUpPanel(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 65),
      physics: BouncingScrollPhysics(),
      itemCount: context.watch<H001ViewModel>().ballWidgetLists.length + 1,
      itemBuilder: (context, index) {
        return context.watch<H001ViewModel>().ballWidgetLists[index - 1];
      },
      controller: context.watch<H001ViewModel>().h001CenterListViewController,
      separatorBuilder: (context, index) {
        return SizedBox(height: 16);
      },
    );
  }

  Widget makeButton(BuildContext context) {
    return context.watch<H001ViewModel>().isFoldTagRanking()
        ? Positioned(
            child: Hero(
              tag: "H001MakeButton",
              child: Container(
                child: AnimatedContainer(
                  child: FlatButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        context.read<H001ViewModel>().goBallMakePage();
                      }),
                  height: 46.00,
                  width: 47.00,
                  decoration: BoxDecoration(
                      color: Color(0xff3497fd),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                        ),
                      ],
                      shape: BoxShape.circle),
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.only(
                      top: context
                              .watch<H001ViewModel>()
                              .makeButtonDisplayShowFlag
                          ? 0
                          : 120),
                ),
                height: 120,
                alignment: Alignment.topCenter,
              ),
            ),
            bottom: 0,
            right: 16,
          )
        : Container();
  }

  AnimatedContainer addressDisplay(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: context.watch<H001ViewModel>().addressDisplayShowFlag ? 73 : 0,
      padding: EdgeInsets.fromLTRB(16, 11, 16, 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Container(
        height: 46.00,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(12.00),
        ),
        child: FlatButton(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            onPressed: () {
              context.read<H001ViewModel>().moveToH007();
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(context.watch<H001ViewModel>().selectPositionAddress,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xff454f63),
                  )),
            )),
      ),
    );
  }
}
