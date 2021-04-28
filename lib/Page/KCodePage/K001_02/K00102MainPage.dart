import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpFromSearchTitle.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/KCodePage/KCodeDrawer/KCodeDrawer.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../KCodeScrollerControllerAniBuilder.dart';
import '../KCodeScrollerControllerBtn.dart';
import '../KCodeSelectViewModel.dart';
import '../KCodeTopFilterBar.dart';
import 'K00102DrawerBody.dart';

class K00102MainPage extends StatelessWidget {
  final String? searchText;

  final ScrollController? mainScroller;

  final TabController? tabController;

  final GlobalKey<NestedScrollViewState>? kCodeNestedScrollViewKey;

  const K00102MainPage(
      {Key? key,
      this.searchText,
      this.mainScroller,
      this.tabController,
      this.kCodeNestedScrollViewKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<K00102MainPageViewModel>(
        create: (_) => K00102MainPageViewModel(
            searchText: searchText,
            context: context,
            mainScroller: mainScroller,
            kCodeScrollerController: KCodeScrollerController(),
            tabController: tabController,
            kCodeNestedScrollViewKey: kCodeNestedScrollViewKey,
            geoLocationUtilForeGroundUseCase: sl(),
            ballListMediator: BallListMediatorImpl()),
        child: Consumer<K00102MainPageViewModel>(builder: (_, model, __) {
          return Stack(children: [
            Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  KCodeTopFilterBar(
                    searchText: searchText!,
                    descriptionText: "관련 제목",
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
                            index, model.ballListMediator!, BallStyle.Style2,
                            boxDecoration: BoxDecoration(
                                border: Border.all(color: Color(0xffE4E7E8)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0))));
                      })
                ],
              ),
            ),
            model.currentState == SearchCollectMediatorState.Empty
                ? Center(child: Container(child: Text("조회된 결과가 없습니다.")))
                : Container(),
            KCodeScrollerControllerBtn(
              kCodeScrollerController: model.kCodeScrollerController!,
              mainScroller: model.mainScroller!,
            ),
            model.isLoading ? CommonLoadingComponent() : Container()
          ]);
        }));
  }
}

class K00102MainPageViewModel
    extends KCodeSelectViewModel<BallListMediator, FBallResDto>
    implements
        KCodeTopFilterBarListener,
        K00102DrawerBodyListener {
  final String? searchText;
  final BuildContext? context;
  final KCodeScrollerController? kCodeScrollerController;
  final ScrollController? mainScroller;
  final TabController? tabController;
  final BallListMediator? ballListMediator;
  final GeoLocationUtilForeGroundUseCaseInputPort?
      geoLocationUtilForeGroundUseCase;
  final GlobalKey<NestedScrollViewState>? kCodeNestedScrollViewKey;
  K00102DrawerItem? _selectedK00102DrawerItem = K00102DrawerItem.BallPower;
  ScrollController? kCodeNestedScrollInnerScrollController;

  K00102MainPageViewModel(
      {this.searchText,
      this.geoLocationUtilForeGroundUseCase,
      this.context,
      this.kCodeScrollerController,
      this.ballListMediator,
      this.mainScroller,
      this.kCodeNestedScrollViewKey,
      this.tabController,
      this.kCodeNestedScrollInnerScrollController})
      : super(
            searchText,
            context,
            ballListMediator,
            kCodeScrollerController,
            mainScroller,
            tabController,
            kCodeNestedScrollViewKey);

  @override
  void openFilter() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context!,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return KCodeDrawer(
              drawerBody: K00102DrawerBody(
            initSelectItem: _selectedK00102DrawerItem,
            k00102drawerBodyListener: this,
          ));
        });
  }

  @override
  onBodySelectItem(K00102DrawerItem item) {
    _selectedK00102DrawerItem = item;
    switch (_selectedK00102DrawerItem) {
      case K00102DrawerItem.BallPower:
        ballListMediator!.sort = "ballPower,DESC";
        break;
      case K00102DrawerItem.MakeTime:
        ballListMediator!.sort = "makeTime,DESC";
        break;
      case K00102DrawerItem.Hit:
        ballListMediator!.sort = "ballHits,DESC";
        break;
      case K00102DrawerItem.Distance:
        ballListMediator!.sort = "distance,ASC";
        break;
    }
    ballListMediator!.searchFirst();
  }

  @override
  settingCollectMediator() {
    var currentWithLastPositionInMemory =
    geoLocationUtilForeGroundUseCase!.getCurrentWithLastPositionInMemory();

    ballListMediator!.fBallListUpUseCaseInputPort = FBallListUpFromSearchTitle(
        FBallListUpFromSearchTitleReqDto(
            searchText: searchText!,
            longitude: currentWithLastPositionInMemory!.longitude,
            latitude: currentWithLastPositionInMemory!.latitude),
        fBallRepository: sl());
    ballListMediator!.sort = "ballPower,DESC";
  }
}
