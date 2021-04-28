import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BallImageViewerViewModel extends ChangeNotifier {
  BallImageViewerViewModel({this.initIndex}){

      Future.delayed(Duration(milliseconds: 100),(){
        pageController.jumpToPage(initIndex!);
        setCurrentPage(initIndex!);
      });

    init();
  }
  int? initIndex = 0;
  int? currentPage = 0;
  PageController pageController = new PageController();

  setCurrentPage(int value){
    currentPage = value;
    notifyListeners();
  }

  void init() async {

  }

  @override
  void dispose() {
    super.dispose();

  }
}