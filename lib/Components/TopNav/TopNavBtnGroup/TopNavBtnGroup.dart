import 'package:flutter/material.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'TopNavBtnGroupViewModel.dart';



class NavBtnGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopNavBtnGroupViewModel(
        topNavBtnMediator: sl()
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


