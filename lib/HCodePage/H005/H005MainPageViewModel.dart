import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';

class H005MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  TabController tabController ;
  String serachText;
  String searchTilteText;
  String searchTagText;
  H005PageState currentState = H005PageState.Title;
  bool hasClearFlag = false;

  H005MainPageViewModel(this._context,this.serachText, {this.tabController}){
    searchTilteText = serachText;
    searchTagText = '#'+serachText;
    init();
  }

  changeTabIndex(value){
    if(value == 0){
      currentState = H005PageState.Title;
    }else if(value == 1){
      currentState = H005PageState.Tag;
    }
    notifyListeners();
  }
  sethasClearFlag(bool value){
    this.hasClearFlag = value;
    notifyListeners();
  }

  getSearchTextDisplay(){
    if(hasClearFlag){
      return "";
    }
    if(currentState == H005PageState.Title){
      return searchTilteText;
    }else if (currentState == H005PageState.Tag){
      return searchTagText;
    }

  }
  init()async {

  }
}