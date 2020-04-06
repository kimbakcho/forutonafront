import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H004/SearchBarHistoryUtil/BallSearchBarHistoryRepository.dart';
import 'package:provider/provider.dart';

import 'SearchBarHistoryUtil/BallSearchbarHistroyDto.dart';

class H004MainPageViewModel extends ChangeNotifier{
  final BuildContext context;
  FocusNode searchFocusNode =  FocusNode();
  TextEditingController searchTextController = new TextEditingController();
  bool hasSearchTextFocus = true;
  bool searchClearButtonActive = false;
  bool searchClearButtonShow = true;


  BallSearchBarHistoryRepository _ballSearchBarHistoryRepository = BallSearchBarHistoryRepository();

  List<BallSearchbarHistroyDto> searchHistorys = [];


  H004MainPageViewModel(this.context){
    searchFocusNode.addListener(onSearchFocusNode);
    searchTextController.addListener(onSearchTextController);
    _init();
  }
  _init() async {
    await _loadSearchHistory();
  }

  clearSearchText(){
    this.searchTextController.clear();
  }

  removeSearchText(BallSearchbarHistroyDto reqDto)async {
    searchHistorys = await _ballSearchBarHistoryRepository.removeHistroy(reqDto);
    notifyListeners();
  }

  onSearchTextController(){
    notifyListeners();
  }

  onSearchFocusNode(){
    hasSearchTextFocus = searchFocusNode.hasFocus;
    notifyListeners();
  }

  attckSearchFocus(){
    FocusScope.of(context).requestFocus(searchFocusNode);
  }

  onSearch(value) async {
    BallSearchbarHistroyDto saveReq = BallSearchbarHistroyDto(value,DateTime.now());
    searchHistorys = await _ballSearchBarHistoryRepository.saveHistory(saveReq);
  }
  _loadSearchHistory() async {
    searchHistorys = await  _ballSearchBarHistoryRepository.loadHistroy();
    return searchHistorys;
  }

  getSearchHintText(){
    if(hasSearchTextFocus){
      return "검색어를 입력해주세요";
    }else {
      if(searchTextController.text.length > 0){
        return searchTextController.text;
      }else {
        return "검색어를 입력해주세요";
      }
    }
  }


  bool isClearButtonShow(){
    if(!hasSearchTextFocus && searchTextController.text.length == 0){
      return false;
    }else {
      return true;
    }
  }
  bool isClearButtonActive(){
    if(searchTextController.text.length == 0){
      return false;
    }else {
      return true;
    }
  }



}