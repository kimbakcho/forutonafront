import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/X001/TopX001NavExpandComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import '../TopNavRouterType.dart';
import 'H001/TopH001NavExpendComponent.dart';
import 'H001/TopH001NavExpendDto.dart';
import 'H003/TopH003NavExpandComponent.dart';
import 'X002/TopX002NavExpandComponent.dart';

class TopNavExpendGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TopNavExpendGroupViewModel(context),
      child: Consumer<TopNavExpendGroupViewModel>(
        builder: (_,model,__){
          return model._getTopNavExpendComponent();
        }
      ),
    );
  }
}

class TopNavExpendGroupViewModel extends ChangeNotifier {
  TopNavBtnMediator topNavBtnMediator;
  BuildContext context;
  TopNavExpendGroupViewModel(BuildContext context){
    topNavBtnMediator = sl();
    this.context = context;
    topNavBtnMediator.topNavExpendGroupViewModel = this;
  }

  changeExpendWidget(){
    notifyListeners();
  }

  Widget _getTopNavExpendComponent(){
    if(topNavBtnMediator.currentTopNavRouter == TopNavRouterType.H001){
      return TopH001NavExpendComponent(
        topH001NavExpendDto: TopH001NavExpendDto(btnHeightSize: 36,btnWidthSize: MediaQuery.of(context).size.width-75),
      );
    }else if(topNavBtnMediator.currentTopNavRouter == TopNavRouterType.H003){
      return TopH003NavExpandComponent();
    }else if(topNavBtnMediator.currentTopNavRouter == TopNavRouterType.X001){
      return TopX001NavExpandComponent();
    }else if(topNavBtnMediator.currentTopNavRouter == TopNavRouterType.X002){
      return TopX002NavExpandComponent();
    }else {
      return Container();
    }
  }
}