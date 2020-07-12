import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyUtil.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidgetViewController.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidgetViewModel.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';


class FBallDetailReplyViewModel extends ChangeNotifier {
  FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();
  ScrollController replyScrollerController = new ScrollController();
  final FBallReplyWidgetViewController _fBallReplyWidgetViewController;
  final String ballUuid;
  BuildContext _context;
  int _currentPage = 0;
  int _sizeLimit = 20;
  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  FBallReplyWidgetViewModel fBallReplyWidgetViewModel;

  FBallDetailReplyViewModel(
      this.ballUuid, this._context, this._fBallReplyWidgetViewController) {
    replyScrollerController.addListener(_onlistscrollListener);
    init();
  }

  init() async {
    loadDetailReply(_currentPage, _sizeLimit);
  }

  _onlistscrollListener() {
    //바탐
    if (replyScrollerController.offset >=
            replyScrollerController.position.maxScrollExtent &&
        !replyScrollerController.position.outOfRange) {
      if (getReplyContentBars().length < (_currentPage + 1 * _sizeLimit)) {
        return;
      }
      _currentPage++;
      loadDetailReply(_currentPage, _sizeLimit);
    }
  }

  List<FBallReplyContentBar> getReplyContentBars() =>
      _fBallReplyWidgetViewController.replyContentBars;

  loadDetailReply(int page, int size) async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.size = size;
    reqDto.page = page;
    reqDto.detail = true;
    if (page == 0) {
      getReplyContentBars().clear();
      getReplyResWrapDto().replyTotalCount = 0;
      getReplyResWrapDto().contents.clear();
    }
    _fBallReplyWidgetViewController.fBallReplyResWrapDto =
        await _fBallReplyRepository.reqFBallReply(reqDto);
    List<FBallSubReplyResDto> subReplyDto =
        FBallReplyUtil().replyResWrapToSubReplyResDtoList(getReplyResWrapDto());
    getReplyContentBars().addAll(subReplyDto
        .map((e) => FBallReplyContentBar(
            e, true, false, true, MediaQuery.of(_context).size.width))
        .toList());

    notifyListeners();
  }

  FBallReplyResWrapDto getReplyResWrapDto() =>
      _fBallReplyWidgetViewController.fBallReplyResWrapDto;


  void popupInsertReply() async {
    FBallReplyResDto replyResDto =
        await FBallReplyUtil().popupInputDisplay(_context,ballUuid);
    if (replyResDto != null) {
      FBallSubReplyResDto subReplyResDto = FBallSubReplyResDto.fromFBallReplyResDto(replyResDto);
      _fBallReplyWidgetViewController.replyContentBars.insert(
          0,
          FBallReplyContentBar(subReplyResDto, true, false, true,
              MediaQuery.of(_context).size.width));
      _fBallReplyWidgetViewController.fBallReplyResWrapDto.replyTotalCount++;

    }
  }
}

enum ModifyReturnValue { Edit, Delete }
