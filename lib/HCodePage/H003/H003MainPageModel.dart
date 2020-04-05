import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H003/H003PageState.dart';

class H003MainPageModel extends ChangeNotifier{
  H003PageState currentState;
  PageController pageController = PageController();
  H003MainPageModel(){
    currentState = H003PageState.H003_01Page;
  }
  changePage(H003PageState page){
    currentState = page;
    if(page == H003PageState.H003_01Page){
      pageController.jumpToPage(0);
    }else if(page == H003PageState.H003_02Page){
      pageController.jumpToPage(1);
    }
    notifyListeners();
  }


}