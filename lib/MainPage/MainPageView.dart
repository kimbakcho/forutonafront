import 'package:flutter/material.dart';
import 'package:forutonafront/HomePage/HomeMainPage.dart';
import 'package:provider/provider.dart';

import 'BottomNavigation.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainPageViewModel(),
        child: Consumer<MainPageViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  child: Column(children: [
            Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                    controller: model._pageController,
                    children: [HomeMainPage(),Container(child: Text("tet"),)])),
            BottomNavigation(
              bottomNavigationListener: model,
            )
          ])));
        }));
  }
}

class MainPageViewModel extends ChangeNotifier
    implements BottomNavigationListener {
  PageController _pageController = PageController();

  @override
  void onBottomNavClick(BottomNavigationNavType bottomNavigationNavType) {
    switch(bottomNavigationNavType) {
      case BottomNavigationNavType.HOME:
        _pageController.jumpToPage(0);
        break;
      case BottomNavigationNavType.SNS:
        _pageController.jumpToPage(1);
        break;
      case BottomNavigationNavType.SEARCH:
        break;
    }
  }
}
