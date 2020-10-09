import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TopNavBtnGroup/TopNavBtnGroup.dart';
import 'TopNavExpendGroup/TopNavExpendGroup.dart';

class TopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TopNavBarViewModel(),
        child: Consumer<TopNavBarViewModel>(builder: (_, model, __) {
          return Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 3, 16, 10),
              child: Stack(
                  children: <Widget>[TopNavExpendGroup(), NavBtnGroup()]));
        }));
  }
}

class TopNavBarViewModel extends ChangeNotifier {

}
