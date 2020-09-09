import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'INavBtnGroup.dart';
import 'TopNavBtnGroupViewModel.dart';
import '../TopNavBtnMediator.dart';


class NavBtnGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopNavBtnGroupViewModel(),
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


