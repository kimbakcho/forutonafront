import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/Components/TagContainBallCollectWidget/TagContainBallCollectMediator.dart';
import 'package:forutonafront/Page/KCodePage/KCodeDrawer/KCodeDrawer.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagNameItemListUpUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TextMatchTagBallReqDto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../KCodeScrollerControllerAniBuilder.dart';
import '../KCodeSelectViewModel.dart';
import '../KCodeTopFilterBar.dart';
import 'K00103DrawerBody.dart';

class K00103MainPage extends StatelessWidget {
  final String? searchText;

  final ScrollController? mainScroller;

  final TabController? tabController;

  final GlobalKey<NestedScrollViewState>? kCodeNestedScrollViewKey;

  const K00103MainPage(
      {Key? key,
      this.searchText,
      this.mainScroller,
      this.tabController,
      this.kCodeNestedScrollViewKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => K00103MainPageViewModel(
          searchText: searchText,
          context: context,
          mainScroller: mainScroller,
          ballListMediator: TagContainBallCollectMediator(sl()),
          tabController: tabController,
          geoLocationUtilForeGroundUseCase: sl(),
          kCodeScrollerController: KCodeScrollerController(),
          kCodeNestedScrollViewKey: kCodeNestedScrollViewKey),
      child: Consumer<K00103MainPageViewModel>(
        builder: (_, model, __) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    KCodeTopFilterBar(
                      searchText: searchText!,
                      descriptionText: "태그와 연관된 컨텐츠",
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
                          return ListUpBallWidgetFactory.getBallWidget(
                              index, model.ballListMediator!, BallStyle.Style3,
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                  border: Border.all(color: Color(0xffE4E7E8)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))));
                        })
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class K00103MainPageViewModel extends KCodeSelectViewModel
    implements KCodeTopFilterBarListener, K00103DrawerBodyListener {
  final String? searchText;
  final BuildContext? context;
  final KCodeScrollerController? kCodeScrollerController;
  final ScrollController? mainScroller;
  final TabController? tabController;
  final TagContainBallCollectMediator? ballListMediator;
  final GeoLocationUtilForeGroundUseCaseInputPort?
      geoLocationUtilForeGroundUseCase;
  final GlobalKey<NestedScrollViewState>? kCodeNestedScrollViewKey;
  K00103DrawerItem _selectedK00103DrawerItem = K00103DrawerItem.BallPower;
  ScrollController? kCodeNestedScrollInnerScrollController;

  K00103MainPageViewModel(
      {this.searchText,
      this.geoLocationUtilForeGroundUseCase,
      this.context,
      this.kCodeScrollerController,
      this.ballListMediator,
      this.mainScroller,
      this.kCodeNestedScrollViewKey,
      this.tabController})
      : super(searchText, context, ballListMediator, kCodeScrollerController,
            mainScroller, tabController, kCodeNestedScrollViewKey);

  @override
  settingCollectMediator() {
    var searchPosition =
        geoLocationUtilForeGroundUseCase!.getCurrentWithLastPositionInMemory();

    ballListMediator!.fBallListUpUseCaseInputPort = TagNameItemListUpUseCase(
        tagRepository: sl(),
        reqDto: TextMatchTagBallReqDto(
            searchText: searchText,
            mapCenterLongitude: searchPosition!.longitude,
            mapCenterLatitude: searchPosition!.latitude));

    ballListMediator!.sort = "ballPower,DESC";
  }

  @override
  void openFilter() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context!,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return KCodeDrawer(
              drawerBody: K00103DrawerBody(
            initSelectItem: _selectedK00103DrawerItem,
            k00103drawerBodyListener: this,
          ));
        });
  }

  @override
  onBodySelectItem(K00103DrawerItem item) {
    _selectedK00103DrawerItem = item;
    switch (_selectedK00103DrawerItem) {
      case K00103DrawerItem.BallPower:
        ballListMediator!.sort = "ballPower,DESC";
        break;
      case K00103DrawerItem.MakeTime:
        ballListMediator!.sort = "makeTime,DESC";
        break;
      case K00103DrawerItem.Hit:
        ballListMediator!.sort = "ballHits,DESC";
        break;
      case K00103DrawerItem.Distance:
        ballListMediator!.sort = "distance,DESC";
        break;
    }
    ballListMediator!.searchFirst();
  }
}
