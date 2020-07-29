import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/FSort.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPageViewModel.dart';
import 'package:forutonafront/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

import 'H00502DropdownItemType.dart';
import 'H00502OrdersEnum.dart';

class H00502PageViewModel extends ChangeNotifier
    implements
        FBallListUpUseCaseOutputPort,
        RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort {
  final BuildContext context;

  List<TagRankingDto> relationTagRankings = [];
  List<DropdownMenuItem<H00502DropdownItemType>> dropDownItems =
      new List<DropdownMenuItem<H00502DropdownItemType>>();
  List<BallStyle1Widget> ballWidgetLists = [];
  ScrollController mainDropDownBtnController = new ScrollController();

  bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final FBallListUpUseCaseInputPort
      _fBallListUpFromSearchTagNameUseCaseInputPort;

  final RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort
      _rankingFromTagNameOrderByBallPowerUseCaseInputPort;

  final GeoLocationUtilBasicUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  final Function(int count) emitBallListUpFromSearchTagNameBallTotalCount;

  H005MainPageViewModel _h005MainModel;
  List<H00502DropdownItemType> _ordersItems =
      new List<H00502DropdownItemType>();
  H00502DropdownItemType _selectOrder;
  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  bool _initFinishFlag = false;
  String searchTag;

  H00502PageViewModel(
      {@required
          this.context,
      @required
      FBallListUpUseCaseInputPort
              fBallListUpFromSearchTagNameUseCaseInputPort,
      @required
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort
              rankingFromTagNameOrderByBallPowerUseCaseInputPort,
      @required
          GeoLocationUtilBasicUseCaseInputPort geoLocationUtilUseCaseInputPort,
      @required
          this.searchTag,
      @required this.emitBallListUpFromSearchTagNameBallTotalCount
      })
      : _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort,
        _fBallListUpFromSearchTagNameUseCaseInputPort =
            fBallListUpFromSearchTagNameUseCaseInputPort,
        _rankingFromTagNameOrderByBallPowerUseCaseInputPort =
            rankingFromTagNameOrderByBallPowerUseCaseInputPort {
    init();
  }

  init() async {
    _initOrdersItems();
    mainDropDownBtnController.addListener(onScrollListener);


    ballListUpFromSearchTag();

    RelationTagRankingFromTagNameReqDto relationTagRankingFromTagNameReqDto =
        RelationTagRankingFromTagNameReqDto(searchTagName: searchTag);
    _rankingFromTagNameOrderByBallPowerUseCaseInputPort
        .searchRelationTagRankingFromTagNameOrderByBallPower(
            reqDto: relationTagRankingFromTagNameReqDto, outputPort: this);

    _initFinishFlag = true;
  }

  onScrollListener() async {
    if (_isScrollerMoveBottomOver()) {
      setNextPage();
      if (!_hasBalls()) {
        return;
      } else {
        await ballListUpFromSearchTag();
      }
    }
  }

  int setNextPage() => _pageCount++;

  FSorts _makeSearchOrders() {
    FSorts fSort = new FSorts();
    fSort.sorts.add(
        new FSort(EnumToString.parse(selectOrder.value), selectOrder.orders));
    return fSort;
  }

  bool _hasBalls() =>
      !(_pageCount * _ballPageLimitSize > ballWidgetLists.length);

  bool _isScrollerMoveBottomOver() {
    return mainDropDownBtnController.offset >=
            mainDropDownBtnController.position.maxScrollExtent &&
        !mainDropDownBtnController.position.outOfRange;
  }

  H00502DropdownItemType get selectOrder => _selectOrder;

  set selectOrder(H00502DropdownItemType value) {
    _selectOrder = value;
    notifyListeners();
  }

  Future ballListUpFromSearchTag() async {
    isLoading = true;
    var position =
        await _geoLocationUtilUseCaseInputPort.getCurrentWithLastPosition();
    FBallListUpFromTagNameReqDto reqDto = new FBallListUpFromTagNameReqDto(
        searchTag: searchTag,
        sortsJsonText: _makeSearchOrders().toQueryJson(),
        latitude: position.latitude,
        longitude: position.longitude,
        size: _ballPageLimitSize,
        page: _pageCount);
    await _fBallListUpFromSearchTagNameUseCaseInputPort
        .search(reqDto,Pageable(0,10,""),this);
    isLoading = false;
  }

  int setFirstPage() => _pageCount = 0;

  bool isFirstPage(int pageCount) => pageCount == 0;

  onChangeOrder() async {
    setFirstPage();

    ballListUpFromSearchTag();
  }

  _initOrdersItems() {
    _ordersItems.add(H00502DropdownItemType(
        "파워순", H00502OrdersEnum.ballPower, QueryOrders.DESC));
    _ordersItems.add(H00502DropdownItemType(
        "최신순", H00502OrdersEnum.makeTime, QueryOrders.DESC));
    _ordersItems.add(H00502DropdownItemType(
        "거리순", H00502OrdersEnum.distance, QueryOrders.ASC));

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

  isEmptyPage() {
    if (_initFinishFlag && ballWidgetLists.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  onBallListUpFromSearchTagName(List<FBallResDto> fBallResDtoList) {
    if (isFirstPage(_pageCount)) {
      ballWidgetLists.clear();
    }
    ballWidgetLists.addAll(fBallResDtoList
        .map((x) => BallStyle1Widget.create(fBallResDto: x))
        .toList());
    notifyListeners();
  }

  @override
  onBallListUpFromSearchTagNameBallTotalCount(int fBallCount) {
    emitBallListUpFromSearchTagNameBallTotalCount(fBallCount);
  }

  @override
  onRelationTagRankingFromTagNameOrderByBallPower(
      List<TagRankingDto> tagRankingDtos) {
    this.relationTagRankings = tagRankingDtos;
    notifyListeners();
  }

  @override
  void searchResult(PageWrap listUpItem) {
    // TODO: implement searchResult
  }
}
