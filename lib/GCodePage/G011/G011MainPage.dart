import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'G011MainPageViewModel.dart';

class G011MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G011MainPageViewModel(context),
        child: Consumer<G011MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(
                      children: <Widget>[
                        topBar(model),
                        SizedBox(height: 8),
                        resetPwBar(model),
                        secondSecurity(model)
                      ],
                    )))
          ]);
        }));
  }

  Container secondSecurity(G011MainPageViewModel model) {
    return Container(
        height: 48,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Container(
                height: 48,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text("2차 보안 (휴대폰 번호)",
                    style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63))))),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: Color(0xfff2f0f1)))));
  }

  Container resetPwBar(G011MainPageViewModel model) {
    return Container(
        height: 48,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goResetPwPage,
            child: Container(
                height: 48,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text("패스워드 재설정",
                    style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff454f63))))),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: Color(0xfff2f0f1)))));
  }

  Container topBar(G011MainPageViewModel model) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackBtnTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("보안",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
      ]),
    );
  }
}
