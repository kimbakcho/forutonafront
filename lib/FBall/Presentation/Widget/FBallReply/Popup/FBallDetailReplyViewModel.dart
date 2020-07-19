import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/ReplyContentBar/FBallReplyContentBar.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class FBallDetailReplyViewModel extends ChangeNotifier
    with FBallReplyColleague {
  ScrollController replyScrollerController = new ScrollController();
  final String ballUuid;
  final BuildContext context;
  final FBallReplyMediator _fBallReplyMediator;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  int _currentPage = 0;
  int _sizeLimit = 20;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  FBallDetailReplyViewModel(
      {this.ballUuid,
      this.context,
      FBallReplyMediator fBallReplyMediator,
      @required
          FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort})
      : _fBallReplyMediator = fBallReplyMediator,
        _fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort {
    super.mediatorJoin(_fBallReplyMediator);
    replyScrollerController.addListener(_onListScrollListener);
    Future.delayed(Duration.zero, () {
      reqMainReplyList(_currentPage, _sizeLimit);
    });
  }

  _onListScrollListener() {
    if (isScrollerPageOver()) {
      if (isLastPage()) {
        return;
      }
      _currentPage++;
      isLoading = true;
      reqMainReplyList(_currentPage, _sizeLimit);
      isLoading = false;
    }
  }

  bool isScrollerPageOver() {
    return replyScrollerController.offset >=
          replyScrollerController.position.maxScrollExtent &&
      !replyScrollerController.position.outOfRange;
  }

  bool isLastPage() => _fBallReplyMediator.replyList.length <= (_currentPage * _sizeLimit);

  reqMainReplyList(int page, int size) async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.size = size;
    reqDto.page = page;
    reqDto.reqOnlySubReply = false;
    if (page == 0) {
      _fBallReplyMediator.fBallReplyListClear();
    }
    _fBallReplyMediator.reqFBallReply(reqDto);
  }

  get replyContentBars {
    if (isEmptyReply) {
      return [Container()];
    } else {
      return _fBallReplyMediator.replyList
          .map((fBallReply) => FBallReplyContentBar(
                fBallReplyPopupUseCaseInputPort: _fBallReplyPopupUseCaseInputPort,
                fBallReplyMediator: _fBallReplyMediator,
                context: context,
                fBallReply: fBallReply,
              ))
          .toList();
    }
  }

  bool get isEmptyReply {
    return _fBallReplyMediator.replyList.length == 0;
  }

  void popupInsertReply() async {
    _fBallReplyPopupUseCaseInputPort.popupInsertDisplay(context, ballUuid);
  }

  @override
  void dispose() {
    _fBallReplyMediator.removeColleague(this);
    super.dispose();
  }

  @override
  void onUpdateFBallReply() {
    notifyListeners();
  }
}
