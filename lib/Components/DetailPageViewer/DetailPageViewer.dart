import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/DetailPageViewer/DetailPageItemFactory.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'package:provider/provider.dart';

class DetailPageViewer extends StatelessWidget {
  final BallListMediator ballListMediator;
  final DetailPageItemFactory detailPageItemFactory;
  final int initIndex;

  DetailPageViewer({required this.ballListMediator,
    required this.detailPageItemFactory,
    this.initIndex = 0});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DetailPageViewerViewModel(
              ballListMediator: ballListMediator, initIndex: initIndex),
      child: Consumer<DetailPageViewerViewModel>(
        builder: (_, model, __) {
          return Container(
              color: Colors.white,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: model.ballList.length,
                onPageChanged: model.onPageChanged,
                controller: model.pageController,
                itemBuilder: (_, index) {
                  return detailPageItemFactory.getDetailPageWidget(
                      model.ballList[index].ballUuid!,
                      model.ballList[index].ballType!);
                },
              ));
        },
      ),
    );
  }
}

class DetailPageViewerViewModel extends ChangeNotifier {
  final BallListMediator? _ballListMediator;
  final PageController _pageController;
  int initIndex;
  bool pageNotFirstAttach = true;

  DetailPageViewerViewModel(
      {BallListMediator? ballListMediator, this.initIndex = 0})
      : _ballListMediator = ballListMediator,
        _pageController = PageController(initialPage: initIndex) {
    _nextPagePreLoading(initIndex);
  }

  PageController get pageController {
    return _pageController;
  }

  List<FBallResDto> get ballList => _ballListMediator!.itemList;

  void onPageChanged(int value) {
    _nextPagePreLoading(value);
  }

  void _nextPagePreLoading(int nowPageIndex) async {
    if (nowPageIndex + 1 == _ballListMediator!.itemList.length) {
      if (!_ballListMediator!.isLastPage!) {
        await _ballListMediator!.searchNext();
        notifyListeners();
      }
    }
  }
}
