import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/BallNameSearchReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501DropdownItemType.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501Ordersenum.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../H005MainPageViewModel.dart';

class H00501PageViewModel extends ChangeNotifier {
  final BuildContext context;

  List<DropdownMenuItem<H00501DropdownItemType>> dropDownItems =
      new List<DropdownMenuItem<H00501DropdownItemType>>();
  List<H00501DropdownItemType> ordersItems = new List<H00501DropdownItemType>();
  ScrollController mainDropDownBtnController = new ScrollController();
  List<FBallResDto> listUpBalls = [];

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
  FBallRepository _fBallRepository = new FBallRepository();
  H005MainPageViewModel _h005MainModel;
  int _ballPageLimitSize = 20;
  int _pageCount = 0;

  H00501PageViewModel(this.context) {
    _initOrdersItems();
    mainDropDownBtnController.addListener(onScrollListener);
    _h005MainModel = Provider.of<H005MainPageViewModel>(context);
    MultiSorts sorts = _makeSerachOrders();
    onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
  }


  MultiSorts _makeSerachOrders() {
    List<MultiSort> sortlist = new List<MultiSort>();
    sortlist.add(new MultiSort(
        EnumToString.parse(selectOrder.value), selectOrder.orders));
    MultiSorts sorts = new MultiSorts(sortlist);
    return sorts;
  }


  onScrollListener() {
    if (_isScrollerMoveBottomOver()) {
      _pageCount++;
      if (!hasBalls()) {
        return;
      } else {
        MultiSorts sorts = _makeSerachOrders();
        onSearch(
            _h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
      }
    }
}

  bool hasBalls() => !(_pageCount * _ballPageLimitSize > listUpBalls.length);

  bool _isScrollerMoveBottomOver() {
    return mainDropDownBtnController.offset >=
          mainDropDownBtnController.position.maxScrollExtent &&
      !mainDropDownBtnController.position.outOfRange;
  }

  onChangeOrder() {
    _pageCount = 0;
    MultiSorts sorts = _makeSerachOrders();
    this.listUpBalls = [];
    notifyListeners();
    onSearch(_h005MainModel.getSearchText(), sorts, _ballPageLimitSize, _pageCount);
    notifyListeners();
  }

  onSearch(
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    _setIsLoading(true);
    var position = await Geolocator().getLastKnownPosition();
    BallNameSearchReqDto reqDto = new BallNameSearchReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    var listUpBallFromSearchText =
        await _fBallRepository.listUpBallFromSearchText(reqDto);
    if (_isFirstPage(pagecount)) {
      this.listUpBalls = listUpBallFromSearchText.balls;
    } else {
      this.listUpBalls.addAll(listUpBallFromSearchText.balls);
    }
    _h005MainModel.titleSearchCount = listUpBallFromSearchText.searchBallCount;
    _setIsLoading(false);
    notifyListeners();
  }

  bool _isFirstPage(int pagecount) => pagecount == 0;

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
}
