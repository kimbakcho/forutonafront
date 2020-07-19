import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G009/G009MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G009MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G009MainPageViewModel(
          context: context,
          logoutUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl(),
            codeMainPageController: sl()
        ),
        child: Consumer<G009MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 0,
                          width: MediaQuery.of(context).size.width,
                          child: topBar(model)),
                      Positioned(
                        top: 64,
                        width: MediaQuery.of(context).size.width,
                        child: accountColumn(model),
                      ),
                      Positioned(
                          top: 265,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              noticeRowBtn(model),
                              versionInfoRowBtn(model),
                              customerCenterRowBtn(model)
                            ],
                          )),
                      Positioned(
                          bottom: 16,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              height: 52.00,
                              child: FlatButton(
                                onPressed: model.logout,
                                child: Text("로그아웃",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                    )),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff78849e),
                                  border: Border.all(
                                    width: 1.00,
                                    color: Color(0xff454f63),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 3.00),
                                      color:
                                          Color(0xff000000).withOpacity(0.16),
                                      blurRadius: 6,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.00))))
                    ])))
          ]);
        }));
  }

  Container customerCenterRowBtn(G009MainPageViewModel model) {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: model.goCustomCenter,
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("고객센터",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Container versionInfoRowBtn(G009MainPageViewModel model) {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: () {
            model.onVerSionInfo();
          },
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("버전정보",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Container noticeRowBtn(G009MainPageViewModel model) {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: model.goNoticePage,
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("공지사항",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Column accountColumn(G009MainPageViewModel model) {
    return Column(
      children: <Widget>[
        accountRowBtn(model),
        securityRowBtn(model),
        openScopeRowBtn(),
        alarmRowbtn(model)
      ],
    );
  }

  Container alarmRowbtn(G009MainPageViewModel model) {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: model.goAlarmSettingPage,
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("알림",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Container openScopeRowBtn() {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("공개 범위",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Container securityRowBtn(G009MainPageViewModel model) {

    return  model.isForutonaUser() ?
      Container(
      height: 48,
      child: FlatButton(
          onPressed: model.goSecurityPage,
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("보안",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    ): Container();
  }

  Container accountRowBtn(G009MainPageViewModel model) {
    return Container(
      height: 48,
      child: FlatButton(
          onPressed: model.goAccountSettingPage,
          padding: EdgeInsets.all(0),
          child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("계정",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))))),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
    );
  }

  Container topBar(G009MainPageViewModel model) {
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
            child: Text("설정",
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
