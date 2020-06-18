import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class H001Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
        Scaffold(
            body: Container(
                color: Color(0xfff2f0f1),
                child: Stack(children: <Widget>[
                  Column(children: <Widget>[
                    addressDisplay(context),
                    Expanded(
                        child: Stack(children: <Widget>[
                          context.watch<H001ViewModel>().isBallEmpty()
                              ? ballEmptyPanel()
                              : buildListUpPanel(context),
                        ]))
                  ]),
                  makeButton(context),
                  context.watch<H001ViewModel>().isLoading ?
                  CommonLoadingComponent() : Container()
                ])))
      ]);


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
        if (index == 0) {
          return context.watch<H001ViewModel>().isFoldTagRanking()
              ? inlineRanking(context)
              : unInlineRaking(context);
        }
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
                    onPressed:(){
                      context.read<H001ViewModel>().goBallMakePage();
                    }
                  ),
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
                      top: context.watch<H001ViewModel>().makeButtonDisplayShowFlag ? 0 : 120),
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

  Column unInlineRaking(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: context.watch<H001ViewModel>().tagRankingDtos.length,
              itemBuilder: (builder, index) {
                return Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF38CAF5))),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                      onPressed: (){
                        context.read<H001ViewModel>().gotoTagSearch(context.read<H001ViewModel>().tagRankingDtos[index].tagName);
                      },
                      child:Row(children: <Widget>[
                        Text("${context.watch<H001ViewModel>().tagRankingDtos[index].ranking}.",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff454F63)
                            )),
                        SizedBox(width: 12),
                        Text("#${context.watch<H001ViewModel>().tagRankingDtos[index].tagName}",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff454F63)
                            )),
                        Spacer(),

                        SizedBox(width: 12),
                      ])
                    ));
              }),
          height: MediaQuery.of(context).size.height - 240,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xffe9faff),
              border: Border.all(
                width: 1.00,
                color: Color(0xff38caf5),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.00),
                topRight: Radius.circular(10.00),
              ))),
      Container(
          child: FlatButton(
              child: Text("접기",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xffffffff),
                  )),
              onPressed: () {
                context.read<H001ViewModel>().showInlineRankingWidget();
              }),
          height: 54.00,
          margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xff454f63),
              border: Border.all(
                width: 1.00,
                color: Color(0xff454f63),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.00),
                bottomRight: Radius.circular(12.00),
              )))
    ]);
  }



  Container inlineRanking(BuildContext context) {
    return Container(
        child: context.watch<H001ViewModel>().tagRankingDtos.length != 0
            ? Swiper(
                itemCount: context.watch<H001ViewModel>().tagRankingDtos.length,
                autoplay: context.watch<H001ViewModel>().rankingAutoPlay,
                scrollDirection: Axis.vertical,
                autoplayDelay: 2000,
                controller: context.watch<H001ViewModel>().rankingSwiperController,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 40,
                      padding: EdgeInsets.fromLTRB(18, 0, 10, 0),
                      child: FlatButton(
                        onPressed: (){
                          context.read<H001ViewModel>().gotoTagSearch(context.read<H001ViewModel>().tagRankingDtos[index].tagName);
                        },
                        padding: EdgeInsets.all(0),
                        child :Row(children: <Widget>[
                          Text(
                            "${context.watch<H001ViewModel>().tagRankingDtos[index].ranking}.",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff454F63)
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                              "#${context.watch<H001ViewModel>().tagRankingDtos[index].tagName}",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xff454F63)
                              )),
                          Spacer(),
                          SizedBox(width: 12),
                          Container(
                            width: 30,
                            height: 30,
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  context.read<H001ViewModel>().showUnInlineRankingWidget();
                                },
                                child: Icon(ForutonaIcon.down_arrow, size: 10)),
                          )
                        ])
                      ) 
                      );
                },
              )
            : Container(),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        height: context.watch<H001ViewModel>().tagRankingDtos.length == 0 ? 0 : 40,
        decoration: BoxDecoration(
            color: Color(0xffe9faff),
            border: Border.all(width: 1.00, color: Color(0xff38caf5)),
            borderRadius: BorderRadius.circular(10.00)));
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
            offset: Offset(0.00,3.00),
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
            onPressed:() {
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
