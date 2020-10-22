import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';

import 'KCodeScrollerControllerAniBuilder.dart';

abstract class KCodeSelectViewModel<T extends SearchCollectMediator, ResDto>
    extends ChangeNotifier implements SearchCollectMediatorComponent {
  final String searchText;
  final BuildContext context;
  final T collectMediator;
  final KCodeScrollerController kCodeScrollerController;
  final ScrollController mainScroller;
  final TabController tabController;
  final GlobalKey<NestedScrollViewState> kCodeNestedScrollViewKey;
  ScrollController _kCodeNestedScrollInnerScrollController;

  KCodeSelectViewModel(
      this.searchText,
      this.context,
      this.collectMediator,
      this.kCodeScrollerController,
      this.mainScroller,
      this.tabController,
      this.kCodeNestedScrollViewKey) {
    collectMediator.pageLimit = 40;
    collectMediator.registerComponent(this);
    settingCollectMediator();
    collectMediator.searchFirst();
    collectMediator.searchFirst();

    _kCodeNestedScrollInnerScrollController =
        kCodeNestedScrollViewKey.currentState.innerController;

    _kCodeNestedScrollInnerScrollController.addListener(_onScrollerListener);
  }

  _onScrollerListener() {
    var positions2 =
        this._kCodeNestedScrollInnerScrollController.positions.toList();
    print(positions2[0].pixels);
    if (positions2[0].pixels >= positions2[0].maxScrollExtent &&
        !positions2[0].outOfRange) {
      print("onNext");
      onNext();
    }

    if (positions2[0].pixels <= positions2[0].minScrollExtent &&
        !positions2[0].outOfRange) {
      print("onRefreshFirst");
      onRefreshFirst();
    }
  }

  void onEndScroller(ScrollEndNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >= 10.0) {
      kCodeScrollerController.forward();
    } else {
      kCodeScrollerController.reverse();
    }
    notifyListeners();
  }

  onRefreshFirst() {
    collectMediator.searchFirst();
  }

  onNext() {
    collectMediator.searchNext();
  }

  settingCollectMediator();

  @override
  void onItemListEmpty() {
    notifyListeners();
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }

  @override
  void dispose() {
    collectMediator.unregisterComponent(this);
    super.dispose();
  }

  List<ResDto> get itemList {
    return collectMediator.itemList;
  }

  int get itemCount {
    return collectMediator.itemList.length;
  }

  int get totalItemCount {
    return collectMediator.wrapItemList.totalElements;
  }

  bool get isLoading {
    return collectMediator.isLoading;
  }

  SearchCollectMediatorState get currentState {
    return collectMediator.currentState;
  }
}
