import 'package:flutter/cupertino.dart';

class BallImageViewerViewModel extends ChangeNotifier {

  int currentPage = 0;


  setCurrentPage(int value){
    currentPage = value;
    notifyListeners();
  }

}