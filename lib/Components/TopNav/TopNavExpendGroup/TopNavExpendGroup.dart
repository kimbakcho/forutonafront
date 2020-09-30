import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/X001/TopX001NavExpandComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import '../TopNavRouterType.dart';

import 'H003/TopH003NavExpandComponent.dart';
import 'H_I_001/TopH_I_001NavExpendComponent.dart';
import 'H_I_001/TopH_I_001NavExpendDto.dart';
import 'X002/TopX002NavExpandComponent.dart';

class TopNavExpendGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopNavExpendGroupViewModel(
        context: context,
        topNavBtnMediator: sl()
      ),
      child: Consumer<TopNavExpendGroupViewModel>(builder: (_, model, __) {
        return model._getTopNavExpendComponent();
      }),
    );
  }
}

class TopNavExpendGroupViewModel extends ChangeNotifier {
  TopNavBtnMediator topNavBtnMediator;
  BuildContext context;

  TopNavExpendGroupViewModel(
      {@required BuildContext context, @required this.topNavBtnMediator}) {
    this.context = context;
    topNavBtnMediator.topNavExpendGroupViewModel = this;
  }

  changeExpendWidget() {
    notifyListeners();
  }

  Widget _getTopNavExpendComponent() {
    if (topNavBtnMediator.currentTopNavRouter == TopNavRouterType.H_I_001) {
      return TopH_I_001NavExpendComponent(
        topNavBtnMediator: sl(),
        codeMainPageController: sl(),
        topH001NavExpendDto: TopH_I_001NavExpendDto(
            btnHeightSize: 36,
            btnWidthSize: MediaQuery.of(context).size.width - 75),
      );
    } else if (topNavBtnMediator.currentTopNavRouter == TopNavRouterType.H003) {
      return TopH003NavExpandComponent();
    } else if (topNavBtnMediator.currentTopNavRouter == TopNavRouterType.X001) {
      return TopX001NavExpandComponent();
    } else if (topNavBtnMediator.currentTopNavRouter == TopNavRouterType.X002) {
      return TopX002NavExpandComponent();
    } else {
      return Container();
    }
  }
}
