import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBar.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'KPageNavBtn.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(
            codeMainPageController: sl(), context: context),
        child: Consumer<BottomNavigationViewModel>(builder: (_, model, __) {
          return Consumer<BottomNavigationViewModel>(
              builder: (_, model, child) {
            return Container(
                height: 52,
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            model._movePageFromTo(CodeState.H001CODE);
                          },
                          child: Icon(
                            Icons.home,
                            color: model._currentPageState == CodeState.H001CODE
                                ? Color(0xff454F63)
                                : Color(0xffE4E7E8),
                          ))),
                  Expanded(
                      flex: 1,
                      child: KPageNavBtn()),
                  Expanded(
                      flex: 1,
                      child:
                          FlatButton(onPressed: () {}, child: Icon(Icons.add))),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            model._movePageFromTo(CodeState.X001CODE);
                          },
                          child: Icon(
                            ForutonaIcon.officialchannel,
                            color: model._currentPageState == CodeState.X001CODE
                                ? Color(0xff454F63)
                                : Color(0xffE4E7E8),
                          ))),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            model._movePageFromTo(CodeState.X002CODE);
                          },
                          child: Icon(
                            ForutonaIcon.snsservicemenu,
                            size: 19,
                            color: model._currentPageState == CodeState.X002CODE
                                ? Color(0xff454F63)
                                : Color(0xffE4E7E8),
                          ))),
                ]),
                decoration: BoxDecoration(color: Color(0xffffffff), boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  )
                ]));
          });
        }));
  }
}

class BottomNavigationViewModel extends ChangeNotifier {
  final CodeMainPageController codeMainPageController;
  final BuildContext context;

  BottomNavigationViewModel({this.codeMainPageController, this.context});

  _movePageFromTo(CodeState codeState) {
    codeMainPageController.movePageFromTo(
      topTo: codeState,
      topFrom: codeMainPageController.currentState,
      mainTo: codeState
    );
    notifyListeners();
  }

  jumpToPage(){

  }

  CodeState get _currentPageState {
    return codeMainPageController.currentState;
  }
}
