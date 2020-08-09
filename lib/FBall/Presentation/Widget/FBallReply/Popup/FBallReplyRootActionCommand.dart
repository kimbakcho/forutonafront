import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';

import 'package:uuid/uuid.dart';

abstract class FBallReplyRootActionCommand {
  Future<void> init(TextEditingController textEditingController);
  Future<void> execute(String replyContent);
}

class FBallReplyRootActionInsert implements FBallReplyRootActionCommand {

  String _ballUuid;
  FBallReplyMediator _fBallReplyMediator;
  FBallReplyRootActionInsert(this._ballUuid,this._fBallReplyMediator);

  @override
  Future<void> execute(String replyContent) async {
    FBallReplyInsertReqDto fBallReplyInsertReqDto = FBallReplyInsertReqDto();
    fBallReplyInsertReqDto.replyUuid = Uuid().v4();
    fBallReplyInsertReqDto.replyText = replyContent;
    fBallReplyInsertReqDto.ballUuid = _ballUuid;
    await _fBallReplyMediator.insertFBallReply(fBallReplyInsertReqDto);
  }

  @override
  Future<void> init(TextEditingController textEditingController) {

  }
}

class FBallReplyActionUpdate implements FBallReplyRootActionCommand{

  FBallReply _fBallReply;
  FBallReplyMediator _fBallReplyMediator;
  FBallReplyActionUpdate(this._fBallReply,this._fBallReplyMediator);

  @override
  Future<void> execute(String replyContent) async {
    FBallReplyUpdateReqDto fBallReplyUpdateReqDto = new FBallReplyUpdateReqDto();
    fBallReplyUpdateReqDto.replyUuid = _fBallReply.replyUuid;
    fBallReplyUpdateReqDto.replyText = replyContent;
    await _fBallReplyMediator.updateFBallReply(fBallReplyUpdateReqDto);
  }

  @override
  Future<void> init(TextEditingController textEditingController) {
    textEditingController.text = _fBallReply.replyText;
  }

}

class FBallReplySubActionInsert implements FBallReplyRootActionCommand {

  FBallReply _fBallReply;
  FBallReplyMediator _fBallReplyMediator;
  FBallReplySubActionInsert(this._fBallReply,this._fBallReplyMediator);

  @override
  Future<void> execute(String replyContent) async {
    FBallReplyInsertReqDto fBallReplyInsertReqDto = FBallReplyInsertReqDto();
    fBallReplyInsertReqDto.replyUuid = Uuid().v4();
    fBallReplyInsertReqDto.replyText = replyContent;
    fBallReplyInsertReqDto.ballUuid = _fBallReply.ballUuid;
    await _fBallReplyMediator.insertFBallReply(fBallReplyInsertReqDto);
  }

  @override
  Future<void> init(TextEditingController textEditingController) {

  }
}