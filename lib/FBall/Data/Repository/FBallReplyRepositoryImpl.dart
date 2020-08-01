import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallReplyDataSource.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';

class FBallReplyRepositoryImpl implements FBallReplyRepository {
  final FBallReplyDataSource _fBallReplyDataSource;
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  FBallReplyRepositoryImpl(
      {@required FBallReplyDataSource fBallReplyDataSource,
      @required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter})
      : _fBallReplyDataSource = fBallReplyDataSource,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  @override
  Future<FBallReply> deleteFBallReply(String replyUuid) async {
    return await _fBallReplyDataSource.deleteFBallReply(
        replyUuid, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto) async {
    return await _fBallReplyDataSource.getFBallReply(reqDto, FDio.noneToken());
  }

  @override
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto) async {
    return await _fBallReplyDataSource.insertFBallReply(reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallReply> updateFBallReply(FBallReplyUpdateReqDto reqDto) async {
    return await _fBallReplyDataSource.updateFBallReply(reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }
}
