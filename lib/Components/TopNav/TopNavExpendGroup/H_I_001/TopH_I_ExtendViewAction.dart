// ignore: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/Page/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/Page/HCodePage/H008/H008MainView.dart';
import 'package:forutonafront/Page/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/Page/HCodePage/H010/H010MainView.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

// ignore: camel_case_types
abstract class TopH_I_ExtendViewAction {
  void action({BuildContext context});

  factory TopH_I_ExtendViewAction.create(
      {CodeMainPageController codeMainPageController,
      PlaceListFromSearchTextWidgetListener
          placeListFromSearchTextWidgetListener,
      H007Listener h007listener,
      Position currentSearchPosition,
      String searchAddress}) {
    if (codeMainPageController.currentState == CodeState.H001CODE) {
      return H001ExtendViewAction(
          currentSearchPosition: currentSearchPosition,
          h007listener: h007listener,
          searchAddress: searchAddress);
    } else if (codeMainPageController.currentState == CodeState.I001CODE) {
      return I001ExtendViewAction(
          placeListFromSearchTextWidgetListener:
              placeListFromSearchTextWidgetListener);
    } else {
      throw FlutterError("TopH_I_ExtendViewAction not Impl");
    }
  }
}

class H001ExtendViewAction implements TopH_I_ExtendViewAction {
  final H007Listener h007listener;
  final Position currentSearchPosition;
  final String searchAddress;

  H001ExtendViewAction(
      {this.h007listener, this.currentSearchPosition, this.searchAddress});

  @override
  void action({BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "H007"),
        builder: (_) {
          return H007MainPage(
              h007listener: h007listener,
              initPosition: currentSearchPosition,
              address: searchAddress);
        }));
  }
}

class I001ExtendViewAction
    implements TopH_I_ExtendViewAction, InputSearchBarListener {
  final PlaceListFromSearchTextWidgetListener
      placeListFromSearchTextWidgetListener;

  I001ExtendViewAction({this.placeListFromSearchTextWidgetListener});

  @override
  void action({BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "H010"),
        builder: (_) {
          return H010MainView(
            inputSearchBarListener: this,
            searchHistoryDataSourceKey:
                SearchHistoryDataSourceKey.AddressSearchHistoryDataSource,
          );
        }));
  }

  @override
  Future<void> onSearch(String search, {BuildContext context}) async {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "/H008"),
        builder: (_) => H008MainView(
            initSearchText: search,
            placeListFromSearchTextWidgetListener:
                placeListFromSearchTextWidgetListener)));
  }
}
