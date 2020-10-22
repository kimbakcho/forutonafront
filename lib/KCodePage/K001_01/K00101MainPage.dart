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
import '../KCodeSelectViewModel.dart';
import '../KCodeTopFilterBar.dart';
import 'K00101DrawerBody.dart';

class K00101MainPage extends StatelessWidget {
  final String searchText;

  final ScrollController mainScroller;

  final TabController tabController;

  final GlobalKey<NestedScrollViewState> kCodeNestedScrollViewKey;

  const K00101MainPage(
      {Key key,
      @required this.searchText,
      @required this.mainScroller,
      @required this.tabController,
      @required this.kCodeNestedScrollViewKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101MainPageViewModel(
            context: context,
            searchText: searchText,
            tabController: tabController,
            mainScroller: mainScroller,
            kCodeNestedScrollViewKey: kCodeNestedScrollViewKey,
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
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            KCodeTopFilterBar(
                              searchText: searchText,
                              descriptionText: "관련 닉네임",
                              searchResultCountText: "${model.totalItemCount}",
                              kCodeTopFilterBarListener: model,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                itemCount: model.itemCount * 2,
                                separatorBuilder: (_, __) {
                                  return SizedBox(height: 16);
                                },
                                itemBuilder: (context, index) {
                                  var d = (index / 2).toInt();
                                  return UserProfileBar(
                                      fUserInfoSimpleResDto: model.itemList[d]);
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

class K00101MainPageViewModel extends KCodeSelectViewModel<UserInfoCollectMediator,FUserInfoSimpleResDto>
    implements KCodeTopFilterBarListener, K00101DrawerBodyListener {
  final String searchText;
  final BuildContext context;
  final UserInfoCollectMediator userInfoCollectMediator;
  final KCodeScrollerController kCodeScrollerController;
  final ScrollController mainScroller;
  final TabController tabController;
  final GlobalKey<NestedScrollViewState> kCodeNestedScrollViewKey;
  K00101DrawerItem _selectedK00101DrawerItem = K00101DrawerItem.PlayPoint;

  K00101MainPageViewModel(
      {this.searchText,
      this.context,
      this.mainScroller,
      this.tabController,
      this.kCodeNestedScrollViewKey,
      this.userInfoCollectMediator,
      this.kCodeScrollerController})
      : super(
            searchText,
            context,
            userInfoCollectMediator,
            kCodeScrollerController,
            mainScroller,
            tabController,
            kCodeNestedScrollViewKey,
            );

  @override
  settingCollectMediator() {
    userInfoCollectMediator.userInfoListUpUseCaseInputPort =
        UserNickNameWithFullTextMatchIndexUseCase(
            searchText: searchText, fUserRepository: sl());
    userInfoCollectMediator.sort = "playerPower,DESC";
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
