import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

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

  FBallReplyMediator(
      {@required FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort;

  bool addColleague(FBallReplyColleague fBallReplyColleague) {
    _fBallReplyColleagueList.add(fBallReplyColleague);
    return true;
  }

  void removeColleague(FBallReplyColleague fBallReplyColleague) {
    _fBallReplyColleagueList.remove(fBallReplyColleague);
  }

  Future<void> reqFBallReply(FBallReplyReqDto reqDto) async {
    await _fBallReplyUseCaseInputPort.reqFBallReply(reqDto, outputPort: this);
  }

  @override
  void onDeleteFBallReply(String replyUuid) {
    var indexWhere =
        replyList.indexWhere((element) => element.replyUuid == replyUuid);
    var replyItem = replyList[indexWhere];
    replyItem.deleteFlag = true;
    emitAllOnUpdateFBallReply();
  }

  @override
  onFBallReply(FBallReplyResWrapDto fBallReplyResWrapDto) {
    if (isFirstPage(fBallReplyResWrapDto) &&
        isOnlyMainReply(fBallReplyResWrapDto)) {
      replyList.clear();
    }
    if (isFirstPage(fBallReplyResWrapDto) &&
        fBallReplyResWrapDto.onlySubReply) {
      var indexWhere = findSubReplyRootNode(fBallReplyResWrapDto);
      replyList[indexWhere].fBallSubReplys.clear();
    }

    if (isOnlyMainReply(fBallReplyResWrapDto)) {
      replyList.addAll(fBallReplyResWrapDto.contents
          .map((e) => FBallReply.fromFBallReplyResDto(e))
          .toList());
    } else {
      var indexWhere = findSubReplyRootNode(fBallReplyResWrapDto);
      replyList[indexWhere].fBallSubReplys.addAll(fBallReplyResWrapDto.contents
          .map((e) => FBallReply.fromFBallReplyResDto(e))
          .toList());
    }

    emitAllOnUpdateFBallReply();
  }

  int findSubReplyRootNode(FBallReplyResWrapDto fBallReplyResWrapDto) {
    return replyList.indexWhere((element) =>
        element.replyNumber == fBallReplyResWrapDto.contents[0].replyNumber);
  }

  bool isFirstPage(FBallReplyResWrapDto fBallReplyResWrapDto) =>
      fBallReplyResWrapDto.offset == 0;

  bool isOnlyMainReply(FBallReplyResWrapDto fBallReplyResWrapDto) =>
      !fBallReplyResWrapDto.onlySubReply;

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
    replyList.insert(0, FBallReply.fromFBallReplyResDto(fBallReplyResDto));
    emitAllOnUpdateFBallReply();
  }

  @override
  void onUpdateFBallReply(FBallReplyResDto fBallReplyResDto) {
    var indexWhere = replyList.indexWhere(
        (element) => element.replyUuid == fBallReplyResDto.replyUuid);
    var replyItem = replyList[indexWhere];
    replyItem.replyUpdateDateTime = fBallReplyResDto.replyUpdateDateTime;
    replyItem.replyText = fBallReplyResDto.replyText;
    emitAllOnUpdateFBallReply();
  }

  Future<void> insertFBallReply(
      FBallReplyInsertReqDto fBallReplyInsertReqDto) async {
    await _fBallReplyUseCaseInputPort.insertFBallReply(fBallReplyInsertReqDto,
        outputPort: this);
  }

  Future<void> updateFBallReply(
      FBallReplyInsertReqDto fBallReplyInsertReqDto) async {
    await _fBallReplyUseCaseInputPort.updateFBallReply(fBallReplyInsertReqDto,
        outputPort: this);
  }

  void fBallReplyListClear() {
    replyList.clear();
    totalReplyCount = 0;
    emitAllOnUpdateFBallReply();
  }
}
