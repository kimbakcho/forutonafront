import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserNickNameWithFullTextMatchIndexUseCase/UserNickNameWithFullTextMatchIndexUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../KCodeDrawer/KCodeDrawer.dart';
import '../KCodeScrollerControllerAniBuilder.dart';
import '../KCodeScrollerControllerBtn.dart';
import '../KCodeTopFilterBar.dart';
import 'K00101DrawerBody.dart';

class K00101MainPage extends StatelessWidget {
  final String searchText;

  final ScrollController mainScroller;

  final TabController tabController;

  const K00101MainPage(
      {Key key,
      @required this.searchText,
      @required this.mainScroller,
      @required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101MainPageViewModel(
            context: context,
            searchText: searchText,
            tabController: tabController,
            mainScroller: mainScroller,
            kCodeScrollerController: KCodeScrollerController(),
            userInfoCollectMediator: sl()),
        child: Consumer<K00101MainPageViewModel>(builder: (_, model, __) {
          return NotificationListener<ScrollNotification>(
              child: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      child: ListView(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            KCodeTopFilterBar(
                              searchText: searchText,
                              descriptionText: "관련 닉네임",
                              searchResultCountText: "${model.totalItemCount}",
                              kCodeTopFilterBarListener: model,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.itemCount,
                                separatorBuilder: (_, __) {
                                  return SizedBox(height: 16);
                                },
                                itemBuilder: (context, index) {
                                  return UserProfileBar(
                                      fUserInfoSimpleResDto:
                                          model.itemList[index]);
                                })
                          ])),
                  model.currentState == SearchCollectMediatorState.Empty
                      ? Center(child: Container(child: Text("조회된 결과가 없습니다.")))
                      : Container(),
                  KCodeScrollerControllerBtn(
                    kCodeScrollerController: model.kCodeScrollerController,
                    mainScroller: model.mainScroller,
                  ),
                  model.isLoading ? CommonLoadingComponent() : Container()
                ],
              ),
              onNotification: (scrollNotification) {
                if (tabController.index == 1) {
                  if (scrollNotification is ScrollEndNotification) {
                    model.onEndScroller(scrollNotification);
                  }
                }
                return true;
              });
        }));
  }
}

class K00101MainPageViewModel extends ChangeNotifier
    implements
        SearchCollectMediatorComponent,
        KCodeTopFilterBarListener,
        K00101DrawerBodyListener {
  final String searchText;
  final BuildContext context;

  final UserInfoCollectMediator userInfoCollectMediator;
  final KCodeScrollerController kCodeScrollerController;
  final ScrollController mainScroller;
  final TabController tabController;

  K00101DrawerItem _selectedK00101DrawerItem = K00101DrawerItem.PlayPoint;

  K00101MainPageViewModel(
      {this.searchText,
      this.context,
      this.userInfoCollectMediator,
      this.kCodeScrollerController,
      this.mainScroller,
      this.tabController}) {
    userInfoCollectMediator.pageLimit = 40;

    userInfoCollectMediator.userInfoListUpUseCaseInputPort =
        UserNickNameWithFullTextMatchIndexUseCase(
            searchText: searchText, fUserRepository: sl());

    userInfoCollectMediator.registerComponent(this);

    userInfoCollectMediator.searchFirst();
  }

  @override
  void dispose() {
    userInfoCollectMediator.unregisterComponent(this);
    super.dispose();
  }

  List<FUserInfoSimpleResDto> get itemList {
    return userInfoCollectMediator.itemList;
  }

  int get itemCount {
    return userInfoCollectMediator.itemList.length;
  }

  int get totalItemCount {
    return userInfoCollectMediator.wrapItemList.totalElements;
  }

  bool get isLoading {
    return userInfoCollectMediator.isLoading;
  }

  SearchCollectMediatorState get currentState {
    return userInfoCollectMediator.currentState;
  }

  @override
  void onItemListEmpty() {
    notifyListeners();
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }

  @override
  void openFilter() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, _) {
          return KCodeDrawer(
              drawerBody: K00101DrawerBody(
            initSelectItem: _selectedK00101DrawerItem,
            k00101drawerBodyListener: this,
          ));
        });
  }

  void onEndScroller(ScrollEndNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >= 10.0) {
      kCodeScrollerController.forward();
    } else {
      kCodeScrollerController.reverse();
    }
    notifyListeners();
  }

  @override
  onBodySelectItem(K00101DrawerItem item) {
    _selectedK00101DrawerItem = item;
    switch (_selectedK00101DrawerItem) {
      case K00101DrawerItem.PlayPoint:
        userInfoCollectMediator.sort = "playerPower,DESC";
        break;
      case K00101DrawerItem.ABC:
        userInfoCollectMediator.sort = "nickName,DESC";
        break;
      case K00101DrawerItem.Followers:
        userInfoCollectMediator.sort = "followCount,DESC";
        break;
    }
    userInfoCollectMediator.searchFirst();
  }
}
