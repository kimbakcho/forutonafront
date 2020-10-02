import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageScrollController/PageScrollController.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetFactory.dart';

class FullBallHorizontalPageList extends StatelessWidget {
  final BallListMediator ballListMediator;

  const FullBallHorizontalPageList({Key key, this.ballListMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FullBallHorizontalPageListViewModel(
            ballListMediator: ballListMediator),
        child: Consumer<FullBallHorizontalPageListViewModel>(
            builder: (_, model, __) {
          return Container(
            height: 115,
            width: MediaQuery.of(context).size.width - 32,
            child: PageView.builder(
              controller: PageScrollController(
                  scrollController: PageController(),
                  onNextPage: model.onNextPage,
                  onRefreshFirst: model.onRefreshFirst).scrollController,
              itemCount: model.balls.length,
              itemBuilder: (_, index) {
                return ListUpBallWidgetFactory.getBallWidget(
                    index, ballListMediator, Axis.horizontal);
              },
            ),
          )
            ;
        }));
  }
}

class FullBallHorizontalPageListViewModel extends ChangeNotifier implements BallListMediatorComponent {
  final BallListMediator ballListMediator;

  final PageController pageController;

  FullBallHorizontalPageListViewModel({this.ballListMediator}):pageController=PageController(){
    ballListMediator.registerComponent(this);
  }

  List<FBallResDto> get balls {
    return ballListMediator.ballList;
  }

  onNextPage(){
    ballListMediator.searchNext();
  }

  onRefreshFirst(){
    ballListMediator.searchFirst();
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }
}
