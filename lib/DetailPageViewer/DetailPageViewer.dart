import 'package:flutter/material.dart';
import 'package:forutonafront/DetailPageViewer/DetailPageItemFactory.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:provider/provider.dart';

class DetailPageViewer extends StatelessWidget {
  final BallListMediator _ballListMediator;
  final DetailPageItemFactory _detailPageItemFactory;
  final int initIndex;

  DetailPageViewer(
      {BallListMediator ballListMediator,
      DetailPageItemFactory detailPageItemFactory,
      this.initIndex = 0})
      : _ballListMediator = ballListMediator,
        _detailPageItemFactory = detailPageItemFactory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailPageViewerViewModel(
          ballListMediator: _ballListMediator, initIndex: initIndex),
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
                  return _detailPageItemFactory.getDetailPageWidget(
                      model.ballList[index].ballUuid,
                      model.ballList[index].ballType);
                },
              ));
        },
      ),
    );
  }
}

class DetailPageViewerViewModel extends ChangeNotifier {
  final BallListMediator _ballListMediator;
  final PageController _pageController;
  int initIndex;
  bool pageNotFirstAttach = true;

  DetailPageViewerViewModel(
      {BallListMediator ballListMediator, this.initIndex = 0})
      : _ballListMediator = ballListMediator,
        _pageController = PageController(initialPage: initIndex) {
    _nextPagePreLoading(initIndex);
  }

  PageController get pageController {
    return _pageController;
  }

  List<FBallResDto> get ballList => _ballListMediator.ballList;

  void onPageChanged(int value) {
    _nextPagePreLoading(value);
  }

  void _nextPagePreLoading(int nowPageIndex) async {
    if (nowPageIndex + 1 == _ballListMediator.ballList.length) {
      if (!_ballListMediator.isLastPage) {
        await _ballListMediator.searchNext();
        notifyListeners();
      }
    }
  }
}
