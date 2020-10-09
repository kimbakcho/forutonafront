import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:provider/provider.dart';

import 'TopNavBtnGroup/TopNavBtnGroup.dart';
import 'TopNavBtnMediator.dart';
import 'TopNavExpendGroup/TopNavExpendGroup.dart';

class TopNavBar extends StatelessWidget {
  final TopNavBtnMediator topNavBtnMediator;
  final CodeMainPageController codeMainPageController;
  final Map<CodeState, Widget> codeStateExpendWidgetMap;
  final List<NavBtn> navBtnList;

  const TopNavBar(
      {Key key,
      this.topNavBtnMediator,
      this.codeMainPageController,
      this.codeStateExpendWidgetMap,
      this.navBtnList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TopNavBarViewModel(),
        child: Consumer<TopNavBarViewModel>(builder: (_, model, __) {
          return Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 3, 16, 10),
              child: Stack(children: <Widget>[
                TopNavExpendGroup(
                  topNavBtnMediator: topNavBtnMediator,
                  codeStateExpendWidgetMap: codeStateExpendWidgetMap,
                ),
                NavBtnGroup(
                  topNavBtnMediator: topNavBtnMediator,
                  navBtnList: navBtnList,
                )
              ]));
        }));
  }
}

class TopNavBarViewModel extends ChangeNotifier {}
