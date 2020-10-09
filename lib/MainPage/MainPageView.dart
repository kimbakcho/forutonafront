import 'package:flutter/material.dart';
import 'package:forutonafront/HomePage/HomeMainPage.dart';

import 'BottomNavigation.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: PageView(
                children: [HomeMainPage()])
            ),
            BottomNavigation()
          ],
        ),
      ),
    );
  }
}
