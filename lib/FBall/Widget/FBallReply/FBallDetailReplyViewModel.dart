import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyContentBar.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailSubReplyInputView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyUtil.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyWidgetViewController.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyWidgetViewModel.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:provider/provider.dart';


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

  FBallDetailReplyViewModel(this.ballUuid, this._context,this._fBallReplyWidgetViewController) {
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

  List<FBallReplyContentBar> getReplyContentBars() => _fBallReplyWidgetViewController.replyContentBars;

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
    _fBallReplyWidgetViewController.fBallReplyResWrapDto = await _fBallReplyRepository.getFBallReply(reqDto);
    List<FBallSubReplyResDto> subReplyDto = FBallReplyUtil().replyResWrapToSubReplyResDtoList(getReplyResWrapDto());
    getReplyContentBars().addAll(subReplyDto
        .map((e) => FBallReplyContentBar(e,true,false,true,MediaQuery.of(_context).size.width)).toList());

    notifyListeners();
  }

  FBallReplyResWrapDto getReplyResWrapDto() => _fBallReplyWidgetViewController.fBallReplyResWrapDto;



  void insertSubReply(FBallSubReplyResDto detailReply) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser != null ){
//      var subReplyItem = await showGeneralDialog(
//          context: scaffold.currentState.context,
//          barrierDismissible: false,
//          transitionDuration: Duration(milliseconds: 300),
//          barrierColor: Colors.black.withOpacity(0.3),
//          barrierLabel:
//          MaterialLocalizations.of(_context).modalBarrierDismissLabel,
//          pageBuilder:
//              (_context, Animation animation, Animation secondaryAnimation) {
//            return ID001DetailSubReplyInputView(detailReply);
//          });
//      if (subReplyItem != null) {
//        detailReply.subReply = subReplyItem;
//      }
    }else {
      Navigator.push(
          _context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/J001"),
              builder: (context) {
                return J001View();
              }));
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
          fBallReplyInsertReqDto.replyUuid = detailReply.replyUuid;
          fBallReplyInsertReqDto.replyText = detailReply.replyText;
          return FBallInputReplyView(fBallReplyInsertReqDto);
        });
    detailReply.replyText = changeText;
  }

  Future<void> replyDeleteAction(FBallReplyResDto detailReply) async {
    await _fBallReplyRepository.deleteFBallReply(detailReply.replyUuid);
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
