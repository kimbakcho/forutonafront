import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G016/G016MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class G016MainPage extends StatelessWidget {
  ScrollController mainScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G016MainPageViewModel(
            context: context,
            mainScrollController: mainScrollController,
            personaSettingNoticeUseCaseInputPort: sl()),
        child: Consumer<G016MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(children: <Widget>[
                      topBar(model),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: noticeListView(model, context),
                      )
                    ])))
          ]);
        }));
  }

  ListView noticeListView(G016MainPageViewModel model, BuildContext context) {
    return ListView.builder(
        controller: model.mainScrollController,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: model.notice.length,
        itemBuilder: (_, index) {
          return Container(
            height: 64,
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  model.goNoticePageInner(model.notice[index].idx);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(model.notice[index].noticeName,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                          Text(
                              DateFormat("yy.MM.dd").format(
                                  model.notice[index].noticeWriteDateTime),
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: Color(0xff454f63),
                              ))
                        ]))),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))),
          );
        });
  }

  Container topBar(G016MainPageViewModel model) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("공지사항",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
