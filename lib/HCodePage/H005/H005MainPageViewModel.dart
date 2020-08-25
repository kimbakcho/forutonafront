import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';

class H005MainPageViewModel extends ChangeNotifier {
  final BuildContext context;
  TabController tabController;

  final String searchText;

  String _searchTitleText;
  String _searchTagText;
  H005PageState currentState = H005PageState.Title;
  bool _hasClearFlag = false;

  bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int titleSearchBallTotalCount = 0;
  int tagSearchBallTotalCount = 0;

  H005MainPageViewModel(
      {@required this.context,
      @required this.searchText,
      @required this.tabController}) {
    _searchTitleText = searchText;
    _searchTagText = '#' + searchText;
    init();
  }

  init() async {}

  getSearchText() {
    return searchText;
  }

  getTitleText() {
    if (titleSearchBallTotalCount == 0) {
      return "Title";
    } else {
      return "Title($titleSearchBallTotalCount)";
    }
  }

  getTagText() {
    if (tagSearchBallTotalCount == 0) {
      return "Tag";
    } else {
      return "Tag($tagSearchBallTotalCount)";
    }
  }

  changeTabIndex(value) {
    if (isTitleIndex(value)) {
      currentState = H005PageState.Title;
    } else if (isTagIndex(value)) {
      currentState = H005PageState.Tag;
    }
    notifyListeners();
  }

  bool isTagIndex(value) => value == 1;

  bool isTitleIndex(value) => value == 0;

  set hasClearFlag(bool value) {
    _hasClearFlag = value;
    notifyListeners();
  }

  getSearchTextDisplay() {
    if (_hasClearFlag) {
      return "";
    }
    if (currentState == H005PageState.Title) {
      return _searchTitleText;
    } else if (currentState == H005PageState.Tag) {
      return _searchTagText;
    }
  }



  onBallListUpFromSearchTitleBallTotalCount(int totalCount) {
    titleSearchBallTotalCount = totalCount;
    notifyListeners();
  }


  onBallListUpFromSearchTagNameBallTotalCount(int totalCount) {
    tagSearchBallTotalCount = totalCount;
    notifyListeners();
  }
}
