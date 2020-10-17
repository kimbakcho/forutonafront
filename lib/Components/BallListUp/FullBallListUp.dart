import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetFactory.dart';

class FullBallListUp extends StatelessWidget {
  final BallListMediator ballListMediator;
  final ScrollPhysics physics;
  final FullBallListUpController fullBallListUpController;

  FullBallListUp(
      {Key key,
      this.ballListMediator,
      this.physics,
      this.fullBallListUpController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FullBallListUpViewModel(
            ballListMediator: ballListMediator,
            fullBallListUpController: fullBallListUpController),
        child: Consumer<FullBallListUpViewModel>(builder: (_, model, __) {
          return ListView.builder(
              shrinkWrap: true,
              physics: physics,
              itemCount: ballListMediator.itemList.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 13),
                  key: Key(ballListMediator.itemList[index].ballUuid),
                  child: ListUpBallWidgetFactory.getBallWidget(
                      index, ballListMediator, BallStyle.Style1,
                      boxDecoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff454F63)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0)))),
                );
              });
        }));
  }
}

class FullBallListUpViewModel extends ChangeNotifier
    implements SearchCollectMediatorComponent {
  final BallListMediator ballListMediator;
  final FullBallListUpController fullBallListUpController;

  FullBallListUpViewModel(
      {this.ballListMediator, this.fullBallListUpController}) {
    if (fullBallListUpController != null) {
      fullBallListUpController.fullBallListUpViewModel = this;
    }

    ballListMediator.registerComponent(this);
  }

  onNextPage() async {
    await ballListMediator.searchNext();
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    super.dispose();
  }

  onRefreshFirst() async {
    await ballListMediator.searchFirst();
  }

  @override
  void onItemListEmpty() {}

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }
}

class FullBallListUpController {
  FullBallListUpViewModel fullBallListUpViewModel;

  onNextPage() async {
    await fullBallListUpViewModel.onNextPage();
  }

  onRefreshFirst() async {
    await fullBallListUpViewModel.onRefreshFirst();
  }
}
