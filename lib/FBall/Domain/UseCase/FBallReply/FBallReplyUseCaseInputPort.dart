import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

abstract class FBallReplyUseCaseInputPort {
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto);
  Future<FBallReplyResWrapDto> reqFBallReply(FBallReplyReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort});
  Future<int> updateFBallReply(FBallReplyInsertReqDto reqDto);
  Future<int> deleteFBallReply(String replyUuid);
}