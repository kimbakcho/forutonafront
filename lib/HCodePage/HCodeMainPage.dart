import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:forutonafront/HCodePage/HCodeMainPageViewModel.dart';
import 'package:provider/provider.dart';

class HCodeMainPage extends StatefulWidget {
  @override
  _HCodeMainPageState createState() => _HCodeMainPageState();
}

class _HCodeMainPageState extends State<HCodeMainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => HCodeMainPageViewModel(),
        child: Consumer<HCodeMainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    // padding: EdgeInsets.fromLTRB(
                    //     0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      // 태그 랭킹 펼칠시 숨기기
                      Column(children: <Widget>[
                        Expanded(
                          child: H001Page(
                            influencePowerBallListMediator:
                                BallListMediatorImpl(),
                          ),
                        ),
                      ]),
                    ])))
          ]);
        }));
  }
}
