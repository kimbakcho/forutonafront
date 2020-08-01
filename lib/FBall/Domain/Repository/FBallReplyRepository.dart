
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

abstract class FBallReplyRepository {
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto);
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto);
  Future<FBallReply> updateFBallReply(FBallReplyUpdateReqDto reqDto);
  Future<FBallReply> deleteFBallReply(String replyUuid);
}