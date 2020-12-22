import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'BasicReViewsContentBar.dart';
import 'ReviewCountMediator.dart';
import 'ReviewDeleteMediator.dart';
import 'ReviewInertMediator.dart';
import 'ReviewUpdateMediator.dart';

class BasicReViewsContentBars extends StatelessWidget {
  final String ballUuid;
  final int pageLimit;
  final bool listable;
  final bool showChildReply;
  final bool showEditBtn;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;
  final ReviewDeleteMediator _reviewDeleteMediator;
  final ReviewUpdateMediator _reviewUpdateMediator;
  final bool canSubReplyInsert;

  const BasicReViewsContentBars(
      {Key key,
      this.ballUuid,
      this.pageLimit,
      this.listable,
      this.showChildReply,
      ReviewInertMediator reviewInertMediator,
      ReviewCountMediator reviewCountMediator,
      ReviewDeleteMediator reviewDeleteMediator,
      ReviewUpdateMediator reviewUpdateMediator,
      this.showEditBtn,
      this.canSubReplyInsert})
      : _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator,
        _reviewDeleteMediator = reviewDeleteMediator,
        _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BasicReViewsContentBarsViewModel(
          ballUuid: ballUuid,
          reviewInertMediator: _reviewInertMediator,
          fBallReplyUseCaseInputPort: sl(),
          pageLimit: pageLimit),
      child:
          Consumer<BasicReViewsContentBarsViewModel>(builder: (_, model, __) {
        return model.isLoaded
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                controller: model.scrollController,
                itemCount: model.replys.length,
                itemBuilder: (_, index) {
                  return BasicReViewsContentBar(
                      key: Key(model.replys[index].replyUuid + "_barId"),
                      fBallReplyResDto: model.replys[index],
                      canSubReplyInsert: canSubReplyInsert,
                      hasBottomPadding: true,
                      hasBoardLine: true,
                      reviewCountMediator: _reviewCountMediator,
                      reviewInertMediator: _reviewInertMediator,
                      reviewDeleteMediator: _reviewDeleteMediator,
                      reviewUpdateMediator: _reviewUpdateMediator,
                      showChildReply: showChildReply,
                      showEditBtn: showEditBtn);
                })
            : Container();
      }),
    );
  }
}

class BasicReViewsContentBarsViewModel extends ChangeNotifier
    implements ReviewInertMediatorComponent {
  final String ballUuid;
  final int pageLimit;
  int page = 0;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final ReviewInertMediator _reviewInertMediator;

  bool isLoaded = false;
  bool loadedLatPage = false;
  List<FBallReplyResDto> replys = [];
  ScrollController scrollController;

  BasicReViewsContentBarsViewModel({
    this.ballUuid,
    FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
    ReviewInertMediator reviewInertMediator,
    this.pageLimit,
  })  : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort,
        _reviewInertMediator = reviewInertMediator {
    _reviewInertMediator.registerComponent(this);
    scrollController = ScrollController();
    loadReply();
    scrollController.addListener(scrollListener);
  }

  Future<void> loadReply() async {
    FBallReplyReqDto reqDto = new FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.reqOnlySubReply = false;
    if (!loadedLatPage) {
      PageWrap<FBallReplyResDto> replysTemp =
          await _fBallReplyUseCaseInputPort.reqFBallReply(reqDto,
              Pageable(page: page, size: pageLimit, sort: "replyNumber,DESC"));
      if (replysTemp.first) {
        replys.clear();
      } else if (replysTemp.last) {
        loadedLatPage = true;
      }
      replys.addAll(replysTemp.content);
      isLoaded = true;
      notifyListeners();
    }
  }

  scrollListener() async {
    if (_isScrollerBottomOver()) {
      _scrollerOver();
    }
  }

  bool _isScrollerBottomOver() {
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }

  void _scrollerOver() async {
    page++;
    await loadReply();
    notifyListeners();
  }

  @override
  onInserted(FBallReplyResDto fBallReplyResDto) {
    if (isRootReply(fBallReplyResDto)) {
      replys.insert(0, fBallReplyResDto);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _reviewInertMediator.unregisterComponent(this);
    super.dispose();
  }

  bool isRootReply(FBallReplyResDto fBallReplyResDto) =>
      fBallReplyResDto.replySort == 0;
}
