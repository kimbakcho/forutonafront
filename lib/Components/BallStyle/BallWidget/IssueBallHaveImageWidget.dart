import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'BallBigImagePanelWidget.dart';
import 'BallPositionInfoBar.dart';
import 'BallTitleInfoBar.dart';
import 'IssueBallTopBar.dart';

class IssueBallHaveImageWidget extends StatelessWidget {
  final int index;
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;

  IssueBallHaveImageWidget({Key key, this.index, this.ballListMediator})
      : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
      fBallResDto: ballListMediator.ballList[index],
      geoLocatorAdapter: sl()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          IssueBallHaveImageWidgetViewModel(
              context: context,
              ballListMediator: ballListMediator,
              issueBallDisPlayUseCase: issueBallDisPlayUseCase,
              index: index
          ),
      child: Consumer<IssueBallHaveImageWidgetViewModel>(
        builder: (_, model, __) {
          return Container(
            child: Column(
              children: <Widget>[
                IssueBallTopBar(
                    issueBallDisPlayUseCase: issueBallDisPlayUseCase),
                BallBigImagePanelWidget(
                    ballDisPlayUseCase: issueBallDisPlayUseCase),
                BallTitleInfoBar(
                    issueBallDisPlayUseCase: issueBallDisPlayUseCase,
                    gotoDetailPage: model.moveToDetailPage),
                Divider(
                  color: Color(0xffF4F4F6).withOpacity(0.9),
                  height: 1,
                  thickness: 1,
                ),
                BallPositionInfoBar(
                  gotoDetailPage: model.moveToDetailPage,
                    ballSearchPosition: ballListMediator.searchPosition(),
                    issueBallDisPlayUseCase: issueBallDisPlayUseCase)
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(color: Color(0xff454F63))),
          );
        },
      ),
    );
  }
}

class IssueBallHaveImageWidgetViewModel extends ChangeNotifier {

  final BuildContext context;
  final BallListMediator ballListMediator;
  final int index;
  final BallDisPlayUseCase issueBallDisPlayUseCase;

  IssueBallHaveImageWidgetViewModel(
      {this.context, this.ballListMediator, this.index, this.issueBallDisPlayUseCase});

  moveToDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DetailPageViewer(
        ballListMediator: ballListMediator,
        detailPageItemFactory: sl(),
        initIndex: index,
      );
    }));
  }

}
