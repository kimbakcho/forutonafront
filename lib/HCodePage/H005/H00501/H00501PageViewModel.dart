import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/FSort.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseOutputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501DropdownItemType.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501Ordersenum.dart';

class H00501PageViewModel extends ChangeNotifier
    implements FBallListUpUseCaseOutputPort {
  final BuildContext context;
  final FBallListUpUseCaseInputPort
      _fBallListUpFromSearchTitleUseCaseInputPort;
  final GeoLocationUtilBasicUseCaseInputPort _geoLocationUtilUseCaseIp;
  final Function(int count) onSearchTitleItemCount;
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

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String searchTitle;

  int _ballPageLimitSize = 20;
  int _pageCount = 0;

  bool _initFinishFlag = false;

  H00501PageViewModel(
      {@required
          this.context,
      @required
          this.searchTitle,
      @required
      FBallListUpUseCaseInputPort
              fBallListUpFromSearchTitleUseCaseInputPort,
      @required
          GeoLocationUtilBasicUseCaseInputPort geoLocationUtilUseCaseIp,
      @required
          this.onSearchTitleItemCount})
      : _fBallListUpFromSearchTitleUseCaseInputPort =
            fBallListUpFromSearchTitleUseCaseInputPort,
        _geoLocationUtilUseCaseIp = geoLocationUtilUseCaseIp {
    init();
  }

  init() async {
    _initOrdersItems();
    mainDropDownBtnController.addListener(onScrollListener);
    await ballListUpFromSearchText();
    _initFinishFlag = true;
  }

  Future ballListUpFromSearchText() async {
    isLoading = true;
    var position = await _geoLocationUtilUseCaseIp.getCurrentWithLastPosition();
    var fBallListUpFromSearchTitleReqDto = new FBallListUpFromSearchTitleReqDto(
        searchText: searchTitle,
        sortsJsonText: _makeSearchOrders().toQueryJson(),
        page: _pageCount,
        size: _ballPageLimitSize,
        longitude: position.longitude,
        latitude: position.latitude);
    await _fBallListUpFromSearchTitleUseCaseInputPort.search(
        fBallListUpFromSearchTitleReqDto,Pageable(0,10,""), this);
    isLoading = false;
  }

  FSorts _makeSearchOrders() {
    FSorts fSort = new FSorts();
    fSort.sorts.add(
        new FSort(EnumToString.parse(selectOrder.value), selectOrder.orders));
    return fSort;
  }

  onScrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      setNextPage();
      if (!hasBalls()) {
        return;
      } else {
        await ballListUpFromSearchText();
      }
    }
  }

  int setNextPage() => _pageCount++;

  bool hasBalls() =>
      !(_pageCount * _ballPageLimitSize > ballWidgetLists.length);

  bool _isScrollerMoveBottomOver() {
    return mainDropDownBtnController.offset >=
            mainDropDownBtnController.position.maxScrollExtent &&
        !mainDropDownBtnController.position.outOfRange;
  }

  onChangeOrder() async {
    setFirstPage();
    ballListUpFromSearchText();
  }

  int setFirstPage() => _pageCount = 0;

  bool _isFirstPage(int pageCount) => pageCount == 0;

  _initOrdersItems() {
    ordersItems.add(H00501DropdownItemType(
        "파워순", H00501OrdersEnum.ballPower, QueryOrders.DESC));
    ordersItems.add(H00501DropdownItemType(
        "최신순", H00501OrdersEnum.makeTime, QueryOrders.DESC));
    ordersItems.add(H00501DropdownItemType(
        "거리순", H00501OrdersEnum.distance, QueryOrders.ASC));

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

  isEmptyPage() {
    if (_initFinishFlag && ballWidgetLists.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  onBallListUpFromSearchTitle(List<FBallResDto> fBallResDtoList) {
    if (_isFirstPage(_pageCount)) {
      ballWidgetLists.clear();
    }
    ballWidgetLists.addAll(fBallResDtoList
        .map((x) => BallStyle1Widget.create(fBallResDto: x))
        .toList());
    notifyListeners();
  }

  @override
  onBallListUpFromSearchTitleBallTotalCount(int fBallTotalCount) {
    onSearchTitleItemCount(fBallTotalCount);
  }

  @override
  void searchResult(PageWrap listUpItem) {
    // TODO: implement searchResult
  }
}
