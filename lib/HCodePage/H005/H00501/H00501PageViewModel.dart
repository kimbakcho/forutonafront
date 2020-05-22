import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/BallNameSearchReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1ReFreshBallUtil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetInter.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501DropdownItemType.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501Ordersenum.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../H005MainPageViewModel.dart';

class H00501PageViewModel extends ChangeNotifier implements BallStyle1WidgetInter{
  final BuildContext context;

  List<DropdownMenuItem<H00501DropdownItemType>> dropDownItems =
      new List<DropdownMenuItem<H00501DropdownItemType>>();
  List<H00501DropdownItemType> ordersItems = new List<H00501DropdownItemType>();
  ScrollController mainDropDownBtnController = new ScrollController();
  List<BallStyle1Widget> ballWidgetLists = [];

  H00501DropdownItemType _selectOrder;
  H00501DropdownItemType get selectOrder => _selectOrder;
  set selectOrder(H00501DropdownItemType value) {
    _selectOrder = value;
    notifyListeners();
  }

  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    return _isLoading;
  }

  H005MainPageViewModel _h005MainModel;
  int _ballPageLimitSize = 20;
  int _pageCount = 0;

  H00501PageViewModel(this.context) {
    init();
  }
  init() async{
    _initOrdersItems();
    mainDropDownBtnController.addListener(onScrollListener);
    _h005MainModel = Provider.of<H005MainPageViewModel>(context);
    MultiSorts sorts = _makeSearchOrders();
    _setIsLoading(true);
    var fBallListUpWrapDto = await _onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
    _setListUpBall(_pageCount, fBallListUpWrapDto);
    _setSearchCount(fBallListUpWrapDto);
    _setIsLoading(false);
  }

  MultiSorts _makeSearchOrders() {
    List<MultiSort> sortList = new List<MultiSort>();
    sortList.add(new MultiSort(
        EnumToString.parse(selectOrder.value), selectOrder.orders));
    MultiSorts sorts = new MultiSorts(sortList);
    return sorts;
  }


  onScrollListener() {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!hasBalls()) {
        return;
      } else {
        MultiSorts sorts = _makeSearchOrders();
        _onSearch(
            _h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
      }
    }
}

  bool hasBalls() => !(_pageCount * _ballPageLimitSize > ballWidgetLists.length);

  bool _isScrollerMoveBottomOver() {
    return mainDropDownBtnController.offset >=
          mainDropDownBtnController.position.maxScrollExtent &&
      !mainDropDownBtnController.position.outOfRange;
  }

  onChangeOrder() async{
    _pageCount = 0;
    MultiSorts sorts = _makeSearchOrders();
    this.ballWidgetLists.clear();
    _setIsLoading(true);
    var fBallListUpWrapDto = await _onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
    _setListUpBall(_pageCount, fBallListUpWrapDto);
    _setSearchCount(fBallListUpWrapDto);
    _setIsLoading(false);
  }

  Future<FBallListUpWrapDto> _onSearch(
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    FBallRepository _fBallRepository = new FBallRepository();
    var position = await Geolocator().getLastKnownPosition();
    BallNameSearchReqDto reqDto = new BallNameSearchReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    return await _fBallRepository.listUpBallFromSearchText(reqDto);
  }

  void _setSearchCount(FBallListUpWrapDto listUpBallFromSearchText) => _h005MainModel.titleSearchCount = listUpBallFromSearchText.searchBallCount;

  _setListUpBall(int pageCount, FBallListUpWrapDto listUpBallFromSearchText) {
    if (_isFirstPage(pageCount)) {
      ballWidgetLists.clear();
    }
    ballWidgetLists.addAll(listUpBallFromSearchText.balls
        .map((e) => BallStyle1Widget.create(e.ballType,BallStyle1WidgetController(e,this))).toList());
  }

  bool _isFirstPage(int pageCount) => pageCount == 0;

  _initOrdersItems() {
    ordersItems.add(H00501DropdownItemType(
        "파워순", H00501Ordersenum.ballPower, QueryOrders.DESC));
    ordersItems.add(H00501DropdownItemType(
        "최신순", H00501Ordersenum.makeTime, QueryOrders.DESC));
    ordersItems.add(H00501DropdownItemType(
        "거리순", H00501Ordersenum.distance, QueryOrders.ASC));

    dropDownItems = ordersItems.map<DropdownMenuItem<H00501DropdownItemType>>(
        (H00501DropdownItemType item) {
      return DropdownMenuItem<H00501DropdownItemType>(
          value: item,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              item.display,
              textAlign: TextAlign.center,
            ),
          ));
    }).toList();
    selectOrder = ordersItems[0];
  }

  @override
  onRequestReFreshBall(FBallResDto reFreshNeedBall) async {
    _setIsLoading(true);
    var ballStyle1ReFreshBallUtil = BallStyle1ReFreshBallUtil();
    await ballStyle1ReFreshBallUtil.reFreshBallAndUiUpdate(ballWidgetLists, reFreshNeedBall, this);
    _setIsLoading(false);
  }
}
