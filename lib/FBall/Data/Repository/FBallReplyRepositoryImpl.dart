import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallReplyDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
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
  Future<int> deleteFBallReply(String replyUuid) async {
    return await _fBallReplyDataSource.deleteFBallReply(
        replyUuid, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallReplyResWrap> getFBallReply(FBallReplyReqDto reqDto) {
    return _fBallReplyDataSource.getFBallReply(reqDto, FDio.noneToken());
  }

  @override
  Future<FBallReply> insertFBallReply(FBallReplyInsertReqDto reqDto) {
    return _fBallReplyDataSource.insertFBallReply(reqDto, FDio.noneToken());
  }

  @override
  Future<int> updateFBallReply(FBallReplyInsertReqDto reqDto) {
    return _fBallReplyDataSource.updateFBallReply(reqDto, FDio.noneToken());
  }
}
