import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';

import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../../FBall/Dto/BallSearchBarHistoryDto.dart';

class H004MainPageViewModel extends ChangeNotifier
    implements BallSearchBarHistoryUseCaseOutputPort {
  final BuildContext context;
  final BallSearchBarHistoryUseCaseInputPort _ballSearchBarHistoryUseCaseInputPort;
  final GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchTextController = new TextEditingController();
  bool hasSearchTextFocus = true;

  List<BallSearchBarHistoryDto> searchHistoryList = [];


  H004MainPageViewModel({
    @required this.context,
    BallSearchBarHistoryUseCaseInputPort ballSearchBarHistoryUseCaseInputPort,
    GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort
  })
      :_ballSearchBarHistoryUseCaseInputPort = ballSearchBarHistoryUseCaseInputPort,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    searchFocusNode.addListener(onSearchFocusNode);
    searchTextController.addListener(onSearchTextController);
    _init();
  }

  _init() async {
    await _loadSearchHistory();
  }

  clearSearchText() {
    this.searchTextController.clear();
  }

  removeSearchText(BallSearchBarHistoryDto reqDto) async {
    await _ballSearchBarHistoryUseCaseInputPort.removeHistory(
        reqDto: reqDto, outputPort: this);
    _loadSearchHistory();
  }

  onSearchTextController() {
    notifyListeners();
  }

  onSearchFocusNode() {
    hasSearchTextFocus = searchFocusNode.hasFocus;
    notifyListeners();
  }

  attckSearchFocus() {
    FocusScope.of(context).requestFocus(searchFocusNode);
  }

  onSearch(value) async {
    BallSearchBarHistoryDto saveReq = BallSearchBarHistoryDto(
        value, DateTime.now());
    await _ballSearchBarHistoryUseCaseInputPort.saveHistory(
        reqDto: saveReq, outputPort: this);
    _loadSearchHistory();
  }

  onSave(value) async {
    BallSearchBarHistoryDto saveReq = BallSearchBarHistoryDto(
        value, DateTime.now());
    await _ballSearchBarHistoryUseCaseInputPort.saveHistory(
        reqDto: saveReq, outputPort: this);
    _loadSearchHistory();
  }

  _loadSearchHistory() async {
    await _ballSearchBarHistoryUseCaseInputPort.loadHistory(outputPort: this);
  }

  getSearchHintText() {
    if (hasSearchTextFocus) {
      return "검색어를 입력해주세요";
    } else {
      if (searchTextController.text.length > 0) {
        return searchTextController.text;
      } else {
        return "검색어를 입력해주세요";
      }
    }
  }

  bool isClearButtonShow() {
    if (hasSearchTextFocus && searchTextController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isClearButtonActive() {
    if (searchTextController.text.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  gotoH005Page(String searchText) async {
    await _geoLocationUtilUseCaseInputPort.useGpsReq();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return H005MainPage(
          searchText: searchText, initPageState: H005PageState.Title);
    }));
  }

  @override
  onLoadHistory(List<BallSearchBarHistoryDto> ballSearchBarHistoryDtos) {
    searchHistoryList = ballSearchBarHistoryDtos;
    notifyListeners();
  }

  @override
  onRemoveHistory() {
    notifyListeners();
  }

  @override
  onSaveHistory() {
    notifyListeners();
  }
}
