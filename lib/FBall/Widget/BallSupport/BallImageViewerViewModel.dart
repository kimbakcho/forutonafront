import 'package:flutter/cupertino.dart';

class BallImageViewerViewModel extends ChangeNotifier {
  BallImageViewerViewModel({this.initIndex}){
    if(initIndex != null){
      Future.delayed(Duration(milliseconds: 100),(){
        pageController.jumpToPage(initIndex);
        setCurrentPage(initIndex);
      });
    }
  }
  int initIndex = 0;
  int currentPage = 0;
  PageController pageController = new PageController();

  setCurrentPage(int value){
    currentPage = value;
    notifyListeners();
  }

}