import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';

import 'ID001DetailSubReplyInputView.dart';
import 'ID001InputReplyView.dart';

class ID001DetailReplyViewModel extends ChangeNotifier {
  FBallReplyResWrapDto fBallReplyResWrapDto = new FBallReplyResWrapDto();
  FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();
  List<FBallSubReplyResDto> detailReply = [];
  ScrollController replyScrollerController = new ScrollController();
  final String ballUuid;
  BuildContext _context;
  int _currentPage = 0;
  int _sizeLimit = 20;

  ID001DetailReplyViewModel(this.ballUuid, this._context) {
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
      if (detailReply.length < (_currentPage + 1 * _sizeLimit)) {
        return;
      }
      _currentPage++;
      loadDetailReply(_currentPage, _sizeLimit);
    }
  }

  loadDetailReply(int page, int size) async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.size = size;
    reqDto.page = page;
    reqDto.detail = true;
    if (page == 0) {
      detailReply.clear();
    }
    fBallReplyResWrapDto = await _fBallReplyRepository.getFBallReply(reqDto);
    var replyResWrapToSubReplyResDtoList2 =
        replyResWrapToSubReplyResDtoList(fBallReplyResWrapDto);
    detailReply.addAll(replyResWrapToSubReplyResDtoList2);
    notifyListeners();
  }

  replyResWrapToSubReplyResDtoList(FBallReplyResWrapDto fBallReplyResWrapDto) {
    var contents = fBallReplyResWrapDto.contents;
    List<FBallSubReplyResDto> fBallSubReplyResDto = [];
    var replyList = contents.where((item) {
      return item.replySort == 0;
    });
    var mainReplyList = replyList.toList();
    mainReplyList.sort((x1, x2) {
      return x1.replyUploadDateTime
              .difference(x2.replyUploadDateTime)
              .isNegative
          ? 1
          : -1;
    });
    for (var mainReply in mainReplyList) {
      FBallSubReplyResDto item =
          FBallSubReplyResDto.fromFBallReplyResDto(mainReply);
      var subReply = contents.where((item) {
        if (item.replySort == 0) {
          return false;
        } else if (item.replyNumber == mainReply.replyNumber) {
          return true;
        } else {
          return false;
        }
      });
      var subReplyList = subReply.toList();
      subReplyList.sort((x1, x2) {
        return x1.replyUploadDateTime
                .difference(x2.replyUploadDateTime)
                .isNegative
            ? 1
            : -1;
      });
      item.subReply = subReplyList;
      fBallSubReplyResDto.add(item);
    }
    return fBallSubReplyResDto;
  }

  void replySubOpenFlagToggle(FBallSubReplyResDto detailReply) {
    detailReply.replyOpenFlag = !detailReply.replyOpenFlag;
    notifyListeners();
  }

  void insertSubReply(FBallSubReplyResDto detailReply) async {
    var subReplyItem = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return ID001DetailSubReplyInputView(detailReply);
        });
    if (subReplyItem != null) {
      detailReply.subReply = subReplyItem;
    }
  }

  void modifyPopup(FBallReplyResDto detailReply) async {
    ModifyReturnValue result = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Positioned(
                    left: 0,
                    bottom: 0,
                    width: MediaQuery.of(_context).size.width,
                    child: Container(
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              onPressed: () {
                                Navigator.of(_context)
                                    .pop(ModifyReturnValue.Edit);
                              },
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                Container(child: Text("수정하기"))
                              ]),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffF5F5F5), width: 1))),
                          ),
                          Container(
                            child: FlatButton(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                onPressed: () {
                                  Navigator.of(_context)
                                      .pop(ModifyReturnValue.Delete);
                                },
                                child: Row(children: <Widget>[
                                  Icon(Icons.delete, color: Colors.black),
                                  Container(
                                    child: Text("삭제하기"),
                                  )
                                ])),
                          )
                        ])))
              ],
            ),
          );
        });
    if (result == ModifyReturnValue.Edit) {
      await replyChangeAction(detailReply);
    } else if (result == ModifyReturnValue.Delete) {
      await replyDelete(detailReply);
    }
  }

  Future replyDelete(FBallReplyResDto detailReply) async {
    ModifyReturnValue result = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Container(
              height: 130.00,
              width: 332.00,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(16),
                      child: Text("삭제 하시겠습니까?",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ))),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(16),
                        height: 32.00,
                        child: FlatButton(
                          onPressed: () async {
                            await replyDeleteAction(detailReply);
                            Navigator.of(_context)
                                .pop(ModifyReturnValue.Delete);
                          },
                          padding: EdgeInsets.all(0),
                          child: Text("삭제",
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xff3497fd),
                              )),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1.00,
                            color: Color(0xff454f63),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 12.00),
                              color: Color(0xff455b63).withOpacity(0.08),
                              blurRadius: 16,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(16),
                        height: 32.00,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(_context).pop();
                          },
                          padding: EdgeInsets.all(0),
                          child: Text("취소",
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xff3497fd),
                              )),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1.00,
                            color: Color(0xff454f63),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 12.00),
                              color: Color(0xff455b63).withOpacity(0.08),
                              blurRadius: 16,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                      ))
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff000000),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.00),
              ),
            )),
          );
        });
    if (result != null && result == ModifyReturnValue.Delete) {
      detailReply.replyText = "삭제 되었습니다.";
      detailReply.deleteFlag = true;
      notifyListeners();
    }
  }

  Future replyChangeAction(FBallReplyResDto detailReply) async {
    var changeText = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          FBallReplyInsertReqDto fBallReplyInsertReqDto =
              FBallReplyInsertReqDto();
          fBallReplyInsertReqDto.ballUuid = detailReply.ballUuid;
          fBallReplyInsertReqDto.idx = detailReply.idx;
          fBallReplyInsertReqDto.replyText = detailReply.replyText;
          return ID001InputReplyView(fBallReplyInsertReqDto);
        });
    detailReply.replyText = changeText;
  }

  Future<void> replyDeleteAction(FBallReplyResDto detailReply) async {
    await _fBallReplyRepository.deleteFBallReply(detailReply.idx);
  }

  void reportPopup(FBallReplyResDto subReply) async {
    await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Positioned(
                    left: 0,
                    bottom: 0,
                    width: MediaQuery.of(_context).size.width,
                    child: Container(
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              onPressed: () {
                                Navigator.of(_context)
                                    .pop();
                              },
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                Container(child: Text("신고하기"))
                              ]),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffF5F5F5), width: 1))),
                          ),

                        ])))
              ],
            ),
          );
        });

  }
}

enum ModifyReturnValue { Edit, Delete }
