import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingWrapDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagSearchFromTextReqDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetInter.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPageViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'H00502DropdownItemType.dart';
import 'H00502Ordersenum.dart';

class H00502pageViewModel extends ChangeNotifier implements BallStyle1WidgetInter{
  final BuildContext context;

  List<TagRankingDto> tagRankings = [];
  List<DropdownMenuItem<H00502DropdownItemType>> dropDownItems =
  new List<DropdownMenuItem<H00502DropdownItemType>>();
  List<BallStyle1Widget> ballWidgetLists = [];
  ScrollController mainDropDownBtnController = new ScrollController();

  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    return _isLoading;
  }
  TagRankingWrapDto _tagRankingWrapDto;
  TagRepository _tagRepository = TagRepository();
  H005MainPageViewModel _h005MainModel;
  List<H00502DropdownItemType> _ordersItems = new List<H00502DropdownItemType>();
  H00502DropdownItemType _selectOrder;
  int _pageCount= 0;
  int _ballPageLimitSize = 20;

  H00502pageViewModel(this.context){
    _h005MainModel = Provider.of<H005MainPageViewModel>(context);
    init();
  }

  onScrollListener() {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!_hasBalls()) {
        return;
      } else {
        MultiSorts sorts = _makeSearchOrders();
        _onSearch(
            _h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
      }
    }
  }

  MultiSorts _makeSearchOrders() {
    List<MultiSort> sortlist = new List<MultiSort>();
    sortlist.add(new MultiSort(
        EnumToString.parse(selectOrder.value), selectOrder.orders));
    MultiSorts sorts = new MultiSorts(sortlist);
    return sorts;
  }

  bool _hasBalls() => !(_pageCount * _ballPageLimitSize > ballWidgetLists.length);

  bool _isScrollerMoveBottomOver() {
    return mainDropDownBtnController.offset >=
      mainDropDownBtnController.position.maxScrollExtent &&
      !mainDropDownBtnController.position.outOfRange;
  }

  init() async{
    _initOrdersItems();
    TagSearchFromTextReqDto reqDto = TagSearchFromTextReqDto.onlyText(_h005MainModel.getSearchText());
    this._tagRankingWrapDto = await _tagRepository.tagSearchFromTextToTagRankings(reqDto);
    this.tagRankings = _tagRankingWrapDto.contents;
    notifyListeners();
    mainDropDownBtnController.addListener(onScrollListener);
    MultiSorts sorts = _makeSearchOrders();
    _setIsLoading(true);
    FBallListUpWrapDto searchResult = await _onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
    _setListUpBall(this._pageCount,searchResult);
    _setTagSearchCount(searchResult);
    _setIsLoading(false);
  }
  H00502DropdownItemType get selectOrder => _selectOrder;

  set selectOrder(H00502DropdownItemType value) {
    _selectOrder = value;
    notifyListeners();
  }
  onChangeOrder() async {
    _pageCount = 0;
    MultiSorts sorts = _makeSearchOrders();
    ballWidgetLists.clear();
    _setIsLoading(true);
    FBallListUpWrapDto searchResult = await _onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
    _setListUpBall(this._pageCount,searchResult);
    _setTagSearchCount(searchResult);
    _setIsLoading(false);
  }

  Future<FBallListUpWrapDto> _onSearch (
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    var position = await Geolocator().getLastKnownPosition();
    TagSearchFromTextReqDto reqDto = new TagSearchFromTextReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    return await _tagRepository.tagSearchFromTextToBalls(reqDto);
  }

  void _setListUpBall(int pagecount, FBallListUpWrapDto listUpBallFromSearchText) {
    if (isFirstPage(pagecount)) {
         ballWidgetLists.clear();
    }
    ballWidgetLists.addAll(listUpBallFromSearchText.balls
        .map((e) => BallStyle1Widget.create(e.ballType,BallStyle1WidgetController(e,this))).toList());
  }

  bool isFirstPage(int pagecount) => pagecount == 0;

  void _setTagSearchCount(FBallListUpWrapDto listUpBallFromSearchText) {
    _h005MainModel.tagSearchCount = listUpBallFromSearchText.searchBallCount;
  }
  _initOrdersItems() {
    _ordersItems.add(H00502DropdownItemType(
        "파워순", H00502Ordersenum.ballPower, QueryOrders.DESC));
    _ordersItems.add(H00502DropdownItemType(
        "최신순", H00502Ordersenum.makeTime, QueryOrders.DESC));
    _ordersItems.add(H00502DropdownItemType(
        "거리순", H00502Ordersenum.distance, QueryOrders.ASC));

    dropDownItems = _ordersItems.map<DropdownMenuItem<H00502DropdownItemType>>(
            (H00502DropdownItemType item) {
          return DropdownMenuItem<H00502DropdownItemType>(
              value: item,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  item.display,
                  textAlign: TextAlign.center,
                ),
              ));
        }).toList();
    selectOrder = _ordersItems[0];
  }

  onRequestReFreshBall(FBallResDto reFreshNeedBall) async {
    _setIsLoading(true);
    var ballStyle1ReFreshBallUtil = BallStyle1ReFreshBallUtil();
    await ballStyle1ReFreshBallUtil.reFreshBallAndUiUpdate(ballWidgetLists, reFreshNeedBall, this);
    _setIsLoading(false);
  }
}