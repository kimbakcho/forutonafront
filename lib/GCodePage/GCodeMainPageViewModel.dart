import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G001/G001MainPageViewModel.dart';
import 'package:forutonafront/GCodePage/G009/G009MainPage.dart';
import 'package:forutonafront/GCodePage/GCodePageState.dart';


class GCodeMainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  GCodePageState currentState;
  G001MainPageViewModel _g001mainPageViewModel;
  PageController gCodePagecontroller = new PageController();
  GCodeMainPageViewModel(this._context,this._g001mainPageViewModel){
    currentState = GCodePageState.G001Page;
    gCodePagecontroller.addListener(onhCodePageChangeListners);

  }
  void jumpToSettingPage()async {
    await Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>G009MainPage()));

    _g001mainPageViewModel.reFreshUserInfo();
    print("test");

  }
  void jumpTopPage(GCodePageState gcode) {
    currentState = gcode;
    if(gcode == GCodePageState.G001Page){
      gCodePagecontroller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }else if(gcode == GCodePageState.G003Page){
      gCodePagecontroller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    }
    notifyListeners();
  }
  onhCodePageChangeListners(){
    if(gCodePagecontroller.page == 0.0){
      currentState = GCodePageState.G001Page;
      notifyListeners();
    }else if(gCodePagecontroller.page == 1.0){
      currentState = GCodePageState.G003Page;
      notifyListeners();
    }
  }


}