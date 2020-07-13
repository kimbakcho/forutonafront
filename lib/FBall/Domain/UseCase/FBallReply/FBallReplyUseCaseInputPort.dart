import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

abstract class FBallReplyUseCaseInputPort {
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<FBallReplyResWrapDto> reqFBallReply(FBallReplyReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<FBallReplyResDto> updateFBallReply(FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<int> deleteFBallReply(String replyUuid,{FBallReplyUseCaseOutputPort outputPort});
}