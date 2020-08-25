import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class BallImageViewerViewModel extends ChangeNotifier {
  BallImageViewerViewModel({this.initIndex}){
    if(initIndex != null){
      Future.delayed(Duration(milliseconds: 100),(){
        pageController.jumpToPage(initIndex);
        setCurrentPage(initIndex);
      });
    }
    init();
  }
  int initIndex = 0;
  int currentPage = 0;
  PageController pageController = new PageController();

  setCurrentPage(int value){
    currentPage = value;
    notifyListeners();
  }

  void init() async {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  void dispose() {
    super.dispose();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
}