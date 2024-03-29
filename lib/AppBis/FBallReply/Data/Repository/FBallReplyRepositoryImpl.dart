import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FBallReplyRepository)
class FBallReplyRepositoryImpl implements FBallReplyRepository {
  final FBallReplyDataSource _fBallReplyDataSource;
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  FBallReplyRepositoryImpl(
      {required FBallReplyDataSource fBallReplyDataSource,
      required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter})
      : _fBallReplyDataSource = fBallReplyDataSource,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  @override
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid) async {
    return await _fBallReplyDataSource.deleteFBallReply(
        replyUuid, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<PageWrap<FBallReplyResDto>> getFBallReply(FBallReplyReqDto reqDto,Pageable pageable) async {
    return await _fBallReplyDataSource.getFBallReply(reqDto,pageable, FDio.noneToken());
  }

  @override
  Future<FBallReplyResDto> insertFBallReply(FBallReplyInsertReqDto reqDto) async {
    return await _fBallReplyDataSource.insertFBallReply(reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallReplyResDto> updateFBallReply(FBallReplyUpdateReqDto reqDto) async {
    return await _fBallReplyDataSource.updateFBallReply(reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int?> getBallReviewCount(String ballUuid) async {
    return await _fBallReplyDataSource.getBallReviewCount(ballUuid,FDio.noneToken());
  }
}
