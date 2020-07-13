import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';
import 'package:forutonafront/ServiceLocator.dart';

class FBallDetailReplyViewModel extends ChangeNotifier
    with FBallReplyColleague {
  ScrollController replyScrollerController = new ScrollController();
  final String ballUuid;
  final BuildContext context;
  final FBallReplyMediator _fBallReplyMediator;

  int _currentPage = 0;
  int _sizeLimit = 20;

  FBallDetailReplyViewModel(
      {this.ballUuid, this.context, FBallReplyMediator fBallReplyMediator})
      : _fBallReplyMediator = fBallReplyMediator {
    super.mediatorJoin(_fBallReplyMediator);
    replyScrollerController.addListener(_onListScrollListener);
    Future.delayed(Duration.zero, () {
      reqMainReplyList(_currentPage, _sizeLimit);
    });
  }

  _onListScrollListener() {
    if (replyScrollerController.offset >=
            replyScrollerController.position.maxScrollExtent &&
        !replyScrollerController.position.outOfRange) {
      if (_fBallReplyMediator.replyList.length <
          (_currentPage + 1 * _sizeLimit)) {
        return;
      }
      _currentPage++;
      reqMainReplyList(_currentPage, _sizeLimit);
    }
  }

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
                fBallReplyMediator: _fBallReplyMediator,
                authUserCaseInputPort: sl(),
                context: context,
                fBallReply: fBallReply,
              ))
          .toList();
    }
  }

  bool get isEmptyReply {
    return _fBallReplyMediator.replyList.length == 0;
  }

  void popupInsertReply() async {}

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
