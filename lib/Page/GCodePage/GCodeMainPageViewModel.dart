import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Page/GCodePage/G009/G009MainPage.dart';
import 'package:forutonafront/Page/GCodePage/GCodePageState.dart';

class GCodeMainPageViewModel extends ChangeNotifier {
  final BuildContext context;
  GCodePageState currentState;
  PageController gCodePageController;

  GCodeMainPageViewModel(
      {@required this.context, @required this.gCodePageController}) {
    currentState = GCodePageState.G001Page;
    gCodePageController.addListener(onhCodePageChangeListners);
  }

  void jumpToSettingPage() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => G009MainPage(),settings: RouteSettings(name: "/G009")));
  }

  void jumpTopPage(GCodePageState gcode) {
    currentState = gcode;
    if (gcode == GCodePageState.G001Page) {
      gCodePageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    } else if (gcode == GCodePageState.G003Page) {
      gCodePageController.animateToPage(1,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }
    notifyListeners();
  }

  onhCodePageChangeListners() {
    if (gCodePageController.page < 0.5) {
      currentState = GCodePageState.G001Page;
      notifyListeners();
    } else if (gCodePageController.page > 0.5) {
      currentState = GCodePageState.G003Page;
      notifyListeners();
    }
  }
}
