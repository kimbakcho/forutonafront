import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetItem.dart';
import 'ReduceSizeAddressBar.dart';
import 'ReduceSizeBallTitleWidget.dart';
import 'ReduceSizeImageWidget.dart';
import 'ReduceSizeTopBar.dart';

class IssueBallReduceSizeWidget extends StatelessWidget {
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;
  final int index;
  final BoxDecoration boxDecoration;

  const IssueBallReduceSizeWidget(
      {Key key,
      this.ballListMediator,
      this.index,
      this.issueBallDisPlayUseCase, this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallReduceSizeWidgetViewModel(
              context: context,
              ballListMediator: ballListMediator,
              index: index,
              issueBallDisPlayUseCase: issueBallDisPlayUseCase,
            ),
        child: Consumer<IssueBallReduceSizeWidgetViewModel>(
            builder: (_, model, __) {
          return Material(
              color: boxDecoration != null ? boxDecoration.color : Colors.white,
              borderRadius: boxDecoration != null ? boxDecoration.borderRadius : null,
              child: InkWell(
                  onTap: () {
                    model.moveToDetailPage();
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                      child: Column(children: [
                        ReduceSizeTopBar(
                            issueBallDisPlayUseCase: issueBallDisPlayUseCase),
                        SizedBox(
                          height: 11,
                        ),
                        Row(children: [
                          Expanded(
                              child: Column(children: [
                            ReduceSizeBallTitleWidget(
                                issueBallDisPlayUseCase:
                                    issueBallDisPlayUseCase),
                                SizedBox(
                                  height: 3,
                                ),
                            ReduceSizeAddressBar(
                                issueBallDisPlayUseCase:
                                    issueBallDisPlayUseCase)
                          ])),
                          Container(
                            width: 70,
                            height: 53,
                            child: issueBallDisPlayUseCase.isMainPicture()
                                ? ReduceSizeImageWidget(
                                    issueBallDisPlayUseCase:
                                        issueBallDisPlayUseCase)
                                : Container(),
                          )
                        ]),
                      ]))));
        }));
  }
}

class IssueBallReduceSizeWidgetViewModel extends ListUpBallWidgetItem {
  final BallDisPlayUseCase issueBallDisPlayUseCase;

  IssueBallReduceSizeWidgetViewModel(
      {this.issueBallDisPlayUseCase,
      BuildContext context,
      BallListMediator ballListMediator,
      int index})
      : super(context, ballListMediator, index);
}
