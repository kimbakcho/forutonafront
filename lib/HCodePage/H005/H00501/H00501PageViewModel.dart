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

  H00501DropdownItemType _selectOrder;

  List<FBallResDto> listUpBalls = [];

  FBallRepository _fBallRepository = new FBallRepository();

  H005MainPageViewModel _h005MainModel;

  int ballPageLimitSize = 20;
  int pageCount = 0;

  ScrollController mainDcollercontroller = new ScrollController();

  H00501PageViewModel(this.context) {
    _initOrdersItems();
    mainDcollercontroller.addListener(onScrollListener);
    _h005MainModel = Provider.of<H005MainPageViewModel>(context);
    List<MultiSort> sortlist = new List<MultiSort>();
    sortlist.add(new MultiSort(
        EnumToString.parse(selectOrder.value), selectOrder.orders));
    MultiSorts sorts = new MultiSorts(sortlist);
    onSearch(_h005MainModel.serachText, sorts, ballPageLimitSize, pageCount);
  }

  H00501DropdownItemType get selectOrder => _selectOrder;

  set selectOrder(H00501DropdownItemType value) {
    _selectOrder = value;
    notifyListeners();
  }

  onScrollListener() {
    if (mainDcollercontroller.offset >=
            mainDcollercontroller.position.maxScrollExtent &&
        !mainDcollercontroller.position.outOfRange) {
      pageCount++;
      if (pageCount * ballPageLimitSize > listUpBalls.length) {
        return;
      } else {
        List<MultiSort> sortlist = new List<MultiSort>();
        sortlist.add(new MultiSort(
            EnumToString.parse(selectOrder.value), selectOrder.orders));
        MultiSorts sorts = new MultiSorts(sortlist);
        onSearch(
            _h005MainModel.serachText, sorts, ballPageLimitSize, pageCount);
      }
    }
}

  onChangeOrder() {
    pageCount = 0;
    List<MultiSort> sortlist = new List<MultiSort>();
    sortlist.add(new MultiSort(
        EnumToString.parse(selectOrder.value), selectOrder.orders));
    MultiSorts sorts = new MultiSorts(sortlist);
    this.listUpBalls = [];
    notifyListeners();
    onSearch(_h005MainModel.serachText, sorts, ballPageLimitSize, pageCount);
    notifyListeners();
  }

  onSearch(
      String searchText, MultiSorts sorts, int pagesize, int pagecount) async {
    var position = await Geolocator().getLastKnownPosition();
    BallNameSearchReqDto reqDto = new BallNameSearchReqDto(
        searchText, sorts.toQureyJson(), pagesize, pagecount,position.latitude,position.longitude);
    var listUpBallFromSearchText =
        await _fBallRepository.listUpBallFromSearchText(reqDto);
    if (pagecount == 0) {
      this.listUpBalls = listUpBallFromSearchText.balls;
    } else {
      this.listUpBalls.addAll(listUpBallFromSearchText.balls);
    }
    _h005MainModel.titleSearchCount = listUpBallFromSearchText.searchBallCount;
    notifyListeners();
  }

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
