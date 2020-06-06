import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseOutputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';

class H005MainPageViewModel extends ChangeNotifier
    implements FBallListUpFromSearchTitleUseCaseOutputPort,FBallListUpFromSearchTagNameUseCaseOutputPort {
  final BuildContext context;
  TabController tabController;

  final String searchText;
  final FBallListUpFromSearchTitleUseCaseInputPort
      fBallListUpFromSearchTitleUseCaseInputPort;

  final FBallListUpFromSearchTagNameUseCaseInputPort
      fBallListUpFromSearchTagUseCaseInputPort;

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
      @required this.fBallListUpFromSearchTitleUseCaseInputPort,
      @required this.fBallListUpFromSearchTagUseCaseInputPort,
      @required this.tabController}) {
    _searchTitleText = searchText;
    _searchTagText = '#' + searchText;
    init();
  }

  init() async {
    this.fBallListUpFromSearchTitleUseCaseInputPort.addBallListUpFromSearchTitleTotalCountListener(outputPort: this);
    this.fBallListUpFromSearchTagUseCaseInputPort.addBallListUpFromSearchTagNameTotalCountListener(outputPort: this);
  }


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

  @override
  onBallListUpFromSearchTitle(List<FBallResDto> fBallList) {
    throw UnimplementedError();
  }

  @override
  onBallListUpFromSearchTitleBallTotalCount(int totalCount) {
    titleSearchBallTotalCount = totalCount;
    notifyListeners();
  }

  @override
  onBallListUpFromSearchTagName(List<FBallResDto> fBallResDtoList) {
    throw UnimplementedError();
  }

  @override
  onBallListUpFromSearchTagNameBallTotalCount(int totalCount) {
    tagSearchBallTotalCount = totalCount;
    notifyListeners();
  }

//  onSearchTagCount(
//      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
//    TagRepository _tagRepository = TagRepository();
//    _setIsLoading(true);
//    var position = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
//    TagSearchFromTextReqDto reqDto = new TagSearchFromTextReqDto(
//        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
//    var listUpBallFromSearchText =
//    await _tagRepository.tagSearchFromTextToBalls(reqDto);
//    this.tagSearchCount = listUpBallFromSearchText.searchBallCount;
//    _setIsLoading(false);
//    notifyListeners();
//  }

}
