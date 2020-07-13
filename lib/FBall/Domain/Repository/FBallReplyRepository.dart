import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

abstract class FBallReplyRepository {
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto);
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto);
  Future<FBallReply> updateFBallReply(FBallReplyInsertReqDto reqDto);
  Future<int> deleteFBallReply(String replyUuid);
}