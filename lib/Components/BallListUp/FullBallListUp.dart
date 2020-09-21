import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetFactory.dart';

class FullBallListUp extends StatelessWidget {
  final BallListMediator ballListMediator;

  const FullBallListUp({Key key, this.ballListMediator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            FullBallListUpViewModel(ballListMediator: ballListMediator),
        child: Consumer<FullBallListUpViewModel>(builder: (_, model, __) {
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: ballListMediator.ballList.length,
              padding: EdgeInsets.all(0),

              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 13),
                  key:  Key(ballListMediator.ballList[index].ballUuid),
                  child: ListUpBallWidgetFactory.getBallWidget(
                      index,
                      ballListMediator
                  ),
                );
              });
        }));
  }
}

class FullBallListUpViewModel extends ChangeNotifier
    implements BallListMediatorComponent {
  final BallListMediator ballListMediator;

  FullBallListUpViewModel({this.ballListMediator}) {
    ballListMediator.registerComponent(this);
  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }

  @override
  void dispose() {
    ballListMediator.unregisterComponent(this);
    super.dispose();
  }
}
