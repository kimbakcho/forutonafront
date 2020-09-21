import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

abstract class ListUpBallWidgetItem extends ChangeNotifier {
  final BuildContext context;
  final BallListMediator ballListMediator;
  final int index;

  ListUpBallWidgetItem(this.context, this.ballListMediator, this.index);

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