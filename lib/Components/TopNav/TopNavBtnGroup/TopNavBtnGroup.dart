import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';

import 'package:provider/provider.dart';
import '../TopNavBtnMediator.dart';
import 'TopNavBtnGroupViewModel.dart';



class NavBtnGroup extends StatelessWidget {
  final List<NavBtn> navBtnList;
  final TopNavBtnMediator topNavBtnMediator;

  const NavBtnGroup({Key key, this.navBtnList,this.topNavBtnMediator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopNavBtnGroupViewModel(
        navBtnList: navBtnList,
        topNavBtnMediator: topNavBtnMediator
      ),
      child: Consumer<TopNavBtnGroupViewModel>(
        builder: (_,model,child){
          return Container(
            child: Stack(
              children: model.navBtnList,
            ),
          );
        }
      ),
    );
  }
}


