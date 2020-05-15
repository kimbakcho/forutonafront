import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/Common/Tag/Dto/TagSearchFromTextReqDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/FBall/Dto/BallNameSearchReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'H00502/H00502pageViewModel.dart';

class H005MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  TabController tabController ;
  final String _searchText;
  String searchTitleText;
  String _searchTagText;
  H005PageState currentState = H005PageState.Title;
  bool hasClearFlag = false;

  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    return _isLoading;
  }
  int _titleSearchCount=0;
  int _tagSearchCount=0;
  H005MainPageViewModel(this._context,this._searchText, {this.tabController}){
    searchTitleText = _searchText;
    _searchTagText = '#'+_searchText;
    init();
  }

  init()async {
    List<MultiSort> sortlist = new List<MultiSort>();
    sortlist.add(new MultiSort(
        "ballPower", QueryOrders.DESC));
    MultiSorts sorts = new MultiSorts(sortlist);
    this.onSearchTextCount(_searchText,sorts,10,0);
    this.onSearchTagCount(_searchText,sorts,10,0);
  }

  int get tagSearchCount => _tagSearchCount;

  set tagSearchCount(int value) {
    _tagSearchCount = value;
    notifyListeners();
  }

  int get titleSearchCount => _titleSearchCount;

  set titleSearchCount(int value) {
    _titleSearchCount = value;
    notifyListeners();
  }

  getSearchText(){
    return _searchText;
  }

  getTitleText(){
    if(titleSearchCount == 0){
      return "Title";
    }else {
      return "Title($titleSearchCount)";
    }
  }
  getTagText(){
    if(tagSearchCount == 0){
      return "Tag";
    }else {
      return "Tag($tagSearchCount)";
    }
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
      return searchTitleText;
    }else if (currentState == H005PageState.Tag){
      return _searchTagText;
    }

  }
  onSearchTextCount(
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    FBallRepository _fBallRepository = new FBallRepository();
    _setIsLoading(true);
    var position = await Geolocator().getLastKnownPosition();
    BallNameSearchReqDto reqDto = new BallNameSearchReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    var listUpBallFromSearchText =
    await _fBallRepository.listUpBallFromSearchText(reqDto);
    this.titleSearchCount = listUpBallFromSearchText.searchBallCount;
    _setIsLoading(false);
    notifyListeners();
  }

  onSearchTagCount(
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    TagRepository _tagRepository = TagRepository();
    _setIsLoading(true);
    var position = await Geolocator().getLastKnownPosition();
    TagSearchFromTextReqDto reqDto = new TagSearchFromTextReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    var listUpBallFromSearchText =
    await _tagRepository.tagSearchFromTextToBalls(reqDto);
    this.tagSearchCount = listUpBallFromSearchText.searchBallCount;
    _setIsLoading(false);
    notifyListeners();
  }

}