import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBall.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';

import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class FBallReplyColleague {
  FBallReplyMediator _ballReplyMediator;

  bool mediatorJoin(FBallReplyMediator fBallReplyMediator) {
    if (fBallReplyMediator == null) {
      return false;
    }
    this._ballReplyMediator = fBallReplyMediator;
    return _ballReplyMediator.addColleague(this);
  }

  void onUpdateFBallReply();
}

class FBallReplyMediator implements FBallReplyUseCaseOutputPort {
  final List<FBallReplyColleague> _fBallReplyColleagueList = [];
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final List<FBallReply> replyList = [];
  int totalReplyCount = 0;
  FBall _fBall;

  FBallReplyMediator(
      {@required FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,FBall fBall})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort,_fBall=fBall;

  bool addColleague(FBallReplyColleague fBallReplyColleague) {
    _fBallReplyColleagueList.add(fBallReplyColleague);
    return true;
  }

  void removeColleague(FBallReplyColleague fBallReplyColleague) {
    _fBallReplyColleagueList.remove(fBallReplyColleague);
  }

  Future<void> reqFBallReply(FBallReplyReqDto reqDto,Pageable pageable) async {
    await _fBallReplyUseCaseInputPort.reqFBallReply(reqDto,pageable, outputPort: this);
  }

  @override
  void onDeleteFBallReply(FBallReplyResDto fBallReplyResDto) {
    FBallReply deleteFBallReplyItem =
        findFBallReplyUseFBallReplyResDto(fBallReplyResDto);
    deleteFBallReplyItem.deleteFlag = true;
    emitAllOnUpdateFBallReply();
  }

  @override
  onFBallReply(PageWrap<FBallReplyResDto> fBallReplyResWrapDto) {
//    if (isFirstPage(fBallReplyResWrapDto) &&
//        isOnlyMainReply(fBallReplyResWrapDto)) {
//      replyList.clear();
//    }
//    if (isFirstPage(fBallReplyResWrapDto) &&
//        fBallReplyResWrapDto.onlySubReply) {
//      var indexWhere =
//          findSubReplyRootNode(fBallReplyResWrapDto.contents[0].replyNumber);
//      replyList[indexWhere].fBallSubReplys.clear();
//    }
//
//    if (isOnlyMainReply(fBallReplyResWrapDto)) {
//      replyList.addAll(fBallReplyResWrapDto.contents
//          .map((e) => FBallReply.fromFBallReplyResDto(e))
//          .toList());
//    } else {
//      var indexWhere =
//          findSubReplyRootNode(fBallReplyResWrapDto.contents[0].replyNumber);
//      replyList[indexWhere].fBallSubReplys.addAll(fBallReplyResWrapDto.contents
//          .map((e) => FBallReply.fromFBallReplyResDto(e))
//          .toList());
//    }

    emitAllOnUpdateFBallReply();
  }

  int findSubReplyRootNode(int replyNumber) {
    return replyList
        .indexWhere((element) => element.replyNumber == replyNumber);
  }

//  bool isFirstPage(FBallReplyResWrapDto fBallReplyResWrapDto) =>
//      fBallReplyResWrapDto.offset == 0;
//
//  bool isOnlyMainReply(FBallReplyResWrapDto fBallReplyResWrapDto) =>
//      !fBallReplyResWrapDto.onlySubReply;

  void emitAllOnUpdateFBallReply() {
    _fBallReplyColleagueList.forEach((element) {
      element.onUpdateFBallReply();
    });
  }

  @override
  onFBallReplyTotalCount(int totalCount) {
    totalReplyCount = totalCount;
    emitAllOnUpdateFBallReply();
  }

  @override
  void onInsertFBallReply(FBallReplyResDto fBallReplyResDto) {
//    if (isRootReply(fBallReplyResDto)) {
//      replyList.insert(0, FBallReply.fromFBallReplyResDto(fBallReplyResDto));
//      totalReplyCount++;
////      _fBall.addCommentCount();
//    } else {
//      var indexWhere = findSubReplyRootNode(fBallReplyResDto.replyNumber);
//      replyList[indexWhere]
//          .fBallSubReplys
//          .add(FBallReply.fromFBallReplyResDto(fBallReplyResDto));
//      replyList[indexWhere].subReplyCount =
//          replyList[indexWhere].fBallSubReplys.length;
//    }
//    emitAllOnUpdateFBallReply();
  }

  bool isRootReply(FBallReplyResDto fBallReplyResDto) =>
      fBallReplyResDto.replySort == 0;

  @override
  void onUpdateFBallReply(FBallReplyResDto fBallReplyResDto) {
    FBallReply updateFBallReplyItem =
        findFBallReplyUseFBallReplyResDto(fBallReplyResDto);

    updateFBallReplyItem.replyUpdateDateTime =
        fBallReplyResDto.replyUpdateDateTime;
    updateFBallReplyItem.replyText = fBallReplyResDto.replyText;
    emitAllOnUpdateFBallReply();
  }

  FBallReply findFBallReplyUseFBallReplyResDto(
      FBallReplyResDto fBallReplyResDto) {
    FBallReply selectFBallReplyItem;
    var indexWhere = findSubReplyRootNode(fBallReplyResDto.replyNumber);
    var rootReply = replyList[indexWhere];
    if (isRootReply(fBallReplyResDto)) {
      selectFBallReplyItem = rootReply;
    } else {
      var subIndexWhere = rootReply.fBallSubReplys.indexWhere(
          (element) => element.replyUuid == fBallReplyResDto.replyUuid);
      selectFBallReplyItem = rootReply.fBallSubReplys[subIndexWhere];
    }
    return selectFBallReplyItem;
  }

  Future<void> insertFBallReply(
      FBallReplyInsertReqDto fBallReplyInsertReqDto) async {
    await _fBallReplyUseCaseInputPort.insertFBallReply(fBallReplyInsertReqDto,
        outputPort: this);
  }

  Future<void> updateFBallReply(
      FBallReplyUpdateReqDto fBallReplyUpdateReqDto) async {
    await _fBallReplyUseCaseInputPort.updateFBallReply(fBallReplyUpdateReqDto,
        outputPort: this);
  }

  Future<void> deleteFBallReply(String replyUuid) async {
    await _fBallReplyUseCaseInputPort.deleteFBallReply(replyUuid,
        outputPort: this);
  }

  void fBallReplyListClear() {
    replyList.clear();
    totalReplyCount = 0;
    emitAllOnUpdateFBallReply();
  }
}
