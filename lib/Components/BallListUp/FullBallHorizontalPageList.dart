import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageScrollController/PageScrollController.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetFactory.dart';

class FullBallHorizontalPageList extends StatelessWidget {
  final BallListMediator? ballListMediator;
  final Function(FBallResDto)? onSelectBall;
  final FullBallHorizontalPageListController?
      fullBallHorizontalPageListController;

  const FullBallHorizontalPageList(
      {Key? key,
      this.ballListMediator,
      this.onSelectBall,
      this.fullBallHorizontalPageListController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FullBallHorizontalPageListViewModel(
            onSelectBall: onSelectBall,
            ballListMediator: ballListMediator,
            fullBallHorizontalPageListController:
                fullBallHorizontalPageListController),
        child: Consumer<FullBallHorizontalPageListViewModel>(
            builder: (_, model, __) {
          return Container(
              height: 115,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  onPageChanged: model.pageChange,
                  physics: BouncingScrollPhysics(),
                  controller: PageScrollController(
                          scrollController: model.pageController,
                          onNextPage: model.onNextPage,
                          onRefreshFirst: model.onRefreshFirst)
                      .scrollController,
                  itemCount: model.balls!.length,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: ListUpBallWidgetFactory.getBallWidget(
                          index, ballListMediator!, BallStyle.Style2,
                          boxDecoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE4E7E8)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)))),
                    );
                  }));
        }));
  }
}

class FullBallHorizontalPageListViewModel extends ChangeNotifier
    implements SearchCollectMediatorComponent {
  final BallListMediator? ballListMediator;

  final PageController? pageController;

  final Function(FBallResDto)? onSelectBall;

  final FullBallHorizontalPageListController?
      fullBallHorizontalPageListController;

  FullBallHorizontalPageListViewModel({
    this.ballListMediator,
    this.onSelectBall,
    this.fullBallHorizontalPageListController,
  }) : pageController = PageController() {
    fullBallHorizontalPageListController!._fullBallHorizontalPageListViewModel =
        this;
    ballListMediator!.registerComponent(this);
  }

  void pageChange(int index) {
    if (onSelectBall != null && ballListMediator!.itemList!.length > 0) {
      onSelectBall!(ballListMediator!.itemList![index]);
    }
  }

  List<FBallResDto>? get balls {
    return ballListMediator!.itemList;
  }

  onNextPage() {
    ballListMediator!.searchNext();
  }

  onRefreshFirst() async {
    await ballListMediator!.searchFirst();
    if (ballListMediator!.itemList!.length > 0) {
      onSelectBall!(ballListMediator!.itemList![0]);
    }
  }

  @override
  void dispose() {
    ballListMediator!.unregisterComponent(this);
    super.dispose();
  }

  _moveToBall(FBallResDto fBallResDto) {
    var indexWhere = ballListMediator!.itemList!
        .indexWhere((element) => element.ballUuid == fBallResDto.ballUuid);
    pageController!.jumpToPage(indexWhere);
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }

  @override
  void onItemListEmpty() {}
}

class FullBallHorizontalPageListController {
  FullBallHorizontalPageListViewModel? _fullBallHorizontalPageListViewModel;

  moveToBall(FBallResDto fBallResDto) {
    if (_fullBallHorizontalPageListViewModel != null) {
      _fullBallHorizontalPageListViewModel!._moveToBall(fBallResDto);
    }
  }
}
